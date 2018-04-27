namespace :evaluation do
  desc "Generate Text Evaluations"
  task generate: :environment do
    experiment = Experiment[1]
    EvaluatedText.each do |t|
      statement = Statement.create(experiment_id: experiment.id, value: t.text_data)
      t.questions.each do |question|
        statement.add_question question
      end
    end
  end
end
