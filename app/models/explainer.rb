class Explainer < Sequel::Model
  # This plugin handles timestamps on the database table
  plugin :timestamps, update_on_create: true

  # These associations are macro like methods which add methods to the class
  # - see https://github.com/jeremyevans/sequel
  many_to_many :statements
  many_to_one :explainer_category
  one_through_one :explainer_image
  one_through_one :explainer_text

  # Get questions for this model
  # This is just an example of how you can use a data model you create to generate questions
  def questions
    # Create an empty array
    arr = []
    # Iterate over the range 1 through 5
    (1..5).each do |i|
      # Create a question with:
      # - question text of "Test Likert Question #{i}"
      # - answers based on the array found in the function likert_answers
      # - the STANDARD question type (you can make more question types yourself in app/model/question_type.rb)
      #   - just make sure and also create your QuestionType.new in db/seeds.rb
      # - the LIKERT question type
      # - layer of 0 (which means these questions will be shown before all others of layer > 0)
      arr << get_question("Test Likert Question #{i}",          likert_answers,           QuestionType::STANDARD, QuestionFormat::LIKERT, 0)

      # Create a question with:
      # - question text of "Test Multiple Choice Question #{i}"
      # - answers based on the array found in the function multiple_choice_answers
      # - the ALTERNATE question type (you can make more question types yourself in app/model/question_type.rb)
      #   - just make sure and also create your QuestionType.new in db/seeds.rb
      # - the MULTIPLE question type
      # - layer of 1 (which means these questions will be shown before all others of layer > 1)
      arr << get_question("Test Multiple Choice Question #{i}", multiple_choice_answers,  QuestionType::ALTERNATE, QuestionFormat::MULTIPLE, 1)
    end
    arr
  end

  # Get the question based on the arguments
  # Note: by this example method questions are unique by their value, type and format
  def get_question value, answers, question_type, question_format, layer = 1
    # Create the question and return it, unless the question already exists then return that
    # - the contents of the {curly brackets} are a Ruby Block, passed as the final argument to the find_or_create_question function
    # - the block arguments are passed when the block is called, not here (which is why question is not out of scope)
    # - note that you can ommit the return keyword in Ruby, the last variable used is returned by default
    find_or_create_question(value, answers, question_type, question_format, layer) { |question, answers|
      # Iterate over the answers array
      answers.each do |a|
        # Add the answer to the question (see answer.rb)
        # - or https://github.com/jeremyevans/sequel/blob/master/doc/association_basics.rdoc
        question.add_answer(Answer.find_or_create(value: a))
      end
    }
  end

  # Finds or creates the question, if a create it will call the block passed to make answers
  def find_or_create_question value, answers, question_type, question_format, layer = 0, &block
    # A hash to be used when finding or creating Question
    h = {
      value:              value,
      question_type_id:   QuestionType.type_id(question_type),
      question_format_id: QuestionFormat.type_id(question_format)
    }

    # Find the Question which matches all of the key -> value pairs in h
    question = Question.find(h)

    # If there is no question, we need to create one
    unless question
      # Add layer to the hash (we did not want to search based on layer but do want it added to a new Question)
      h[:layer] = layer
      # Create the question with the fields populated using the key -> value pairs in h
      question = Question.create(h)
      # Execute the block that was passed as &block
      # - In Ruby this will execute the code inline (rather than returning a value from block.call)
      # - question and answers are passed as arguments to the block
      # - See http://awaxman11.github.io/blog/2013/08/05/what-is-the-difference-between-a-block/
      block.call(question, answers)
    end

    # Return the question (ruby returns the last variable when you ommit the return keyword)
    # - so this is the same as return question
    question
  end

  # Just an array of example answers
  def multiple_choice_answers
    ['Answer A', 'Answer B', 'Answer C', 'Answer D']
  end

  # Just an array of example answers
  def likert_answers
    ['Strongly Disagree', 'Slightly Disagree', 'Neither Agree or Disagree', 'Slightly Agree', 'Strongly Agree']
  end
end
