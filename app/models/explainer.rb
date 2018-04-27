class Explainer < Sequel::Model
  plugin :timestamps, update_on_create: true
  many_to_many :statements
  many_to_one :explainer_category
  one_through_one :explainer_image
  one_through_one :explainer_text

  def questions
    arr = []
    (1..5).each do |i|
      arr << likert_question("Test Question #{i}")
    end
    arr
  end

  def likert_question q
    question = Question.find(
      value:              q,
      question_type_id:   QuestionType.type_id(QuestionType::CATEGORY_A),
      question_format_id: QuestionFormat.type_id(QuestionFormat::LIKERT),
      layer:              0
    )

    unless question
      question = Question.create(
        value:              q,
        question_type_id:   QuestionType.type_id(QuestionType::CATEGORY_A),
        question_format_id: QuestionFormat.type_id(QuestionFormat::LIKERT),
        layer:              0
      )
      likert_answers.each do |i|
        answer = Answer.find_or_create(value: i)
        question.add_answer answer
      end
    end

    
    question
  end

  def likert_answers
    ['Strongly Disagree', 'Slightly Disagree', 'Neither Agree or Disagree', 'Slightly Agree', 'Strongly Agree']
  end
end
