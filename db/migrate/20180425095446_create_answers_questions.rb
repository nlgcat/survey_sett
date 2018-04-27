Sequel.migration do
  change do
    create_table :answers_questions do
      foreign_key :answer_id,   :answers,   null: false
      foreign_key :question_id, :questions, null: false
      index [:answer_id, :question_id], unique: true
    end
  end
end
