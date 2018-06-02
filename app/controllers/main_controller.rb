class MainController < ApplicationController
  before_action :check_consent, except: :thank_you

  # FIXME - If the next statement is not read, redirect to the next screen instead.

  def check_consent
    unless current_participant.consented?
      redirect_to '/' and return
    end
  end

  def experiment
    # Check for final consent
    current_participant.update(final_consent: true) if (params[:agree] == '1')

    # Assign the statements if there are none for the participant
    assign_statements unless Test.find(participant_id: current_participant_id)

    redirect_to '/statement'
  end

  # Get the current user position and display
  def statement
    @test = Test.where(participant_id: current_participant_id, completed: false).order(:id).first
    if @test
      if @test.statement_read
        run_test @test
      else
        show_statement @test
      end
    else
      @test.update(completed: true) unless @test == nil
      thank_you
    end
  end

  def statements_remaining
    Test.where(participant_id: current_participant_id, completed: false).order(:id).all.size
  end

  def statements_remaining?
    statements_remaining > 0
  end

  def statements_shown?
    Test.where(participant_id: current_participant_id, statement_shown: true).all.size > 0
  end

  def next
    @remaining = statements_remaining
    # TODO - account for more than 3
    @done = current_participant.tests.size - @remaining
    render :next
  end

  def instructions
    # If the user has read any statements then bunt them there.
    if statements_shown?
      redirect_to '/statement'
    else
      render :instructions
    end
  end

  def test_read
    @test = Test.find(id: params[:id])
    @test.statement_read = true
    @test.save
    redirect_to '/statement'
  end

  def answer
    puts "-- PARAMS --"
    pp params
    puts "\n"
    test_question = TestQuestion.find(id: params[:id])
    # Look for a single answer which is just named 'answer_id'
    answer = Answer.find(id: params[:answer_id])
    answers = []

    if answer
      answers << answer
    else
      # The user may be able to select multiple options, so anything starting with answer_id_*
      params.each do |k,v|
        target = 'answer_id_'
        if k.to_s[0,target.size] == 'answer_id_'
          a = Answer.find(id: v)
          answers << a
        end
      end
    end

    if answers.size == 0
      redirect_to '/statement' and return
    end

    answers.each do |answer|

      test_question.add_answer answer
      # This line may not be required
      test_question.save
    end

    # TODO - Better Sequel
    unanswered = []
    test = test_question.test

    if test.completed
      redirect_to '/statement' and return
    end

    test.test_questions.each do |test_question|
      unanswered << true if test_question.answers.size == 0
    end

    if unanswered.uniq.size == 1
      redirect_to '/statement' and return
    else
      test.update(completed: true)
      if statements_remaining?
        redirect_to '/next' and return
      else
        redirect_to '/thank_you' and return
      end
    end
  end

  def show_statement test
    @test = test
    @statement = test.statement
    @test.update(statement_shown: true)
    render :statement
  end

  def run_test test
    @test = test
    test_questions = test.test_questions.sort_by{|tq| tq.id}
    test_questions.each do |test_question|
      next if test_question.answers.size > 0
      @test_question = test_question
      @question = test_question.question
      render @question.question_format.to_sym
      break
    end
    # test_questions = TestQuestion.where(test_id: test.id).order(:id)
    # test_questions.each do |test_question|
    #   next if test_question.answers.size > 0
    #   @test_question = test_question
    #   @question = test_question.question
    #   render @question.question_format.to_sym
    #   break
    # end
  end

  def thank_you
    if current_participant.final_consent == true
      render :thank_you and return
    else
      render :final_consent and return
    end
  end

  def assign_statements
    finished_participants = Participant.where(final_consent: true).count
    statements = [Statement[(finished_participants % 2) + 1]]

    statements.each do |s|
      t = Test.create(participant_id: current_participant_id, statement_id: s.id)
      q_hash = {}
      s.questions.each do |q|
        q_hash[q.question_type_id] = [] unless q_hash[q.question_type_id]
        q_hash[q.question_type_id] << q
      end
      
      # Limit
      q_arr = []
      QuestionType.limits.each do |k, l|
        sample = q_hash[k] ? q_hash[k].sample(l) : []
        q_arr = q_arr + sample
      end

      # Layer - Postgres does not by default sort ASC PK
      layered_hash = {}
      # FIXME - this is magic numbers, at least use CONSTANTS
      (0..9).to_a.each do |i|
        layered_hash[i]= []
      end
      q_arr.each do |q|
        # layered_hash[q.layer] = [] unless layered_hash[q.layer]
        layered_hash[q.layer] << q
      end

      layered_arr = []
      layered_hash.each do |layer, questions|
        layered_arr = layered_arr + questions.shuffle
      end

      layered_arr.each do |question|
        TestQuestion.create(test_id: t.id, question_id: question.id)
      end
    end
  end

  # type should be :img or :txt
  def get_statements type
    arr = []
    statements = Statement.all
    statements.each do |statement|
      if type == :img
        arr << statement if statement.explainer.explainer_image
      elsif type == :txt
        arr << statement if statement.explainer.explainer_text
      else
        raise "Unknown type in get_statements(#{type})"
      end
    end
    arr.shuffle
  end
end
