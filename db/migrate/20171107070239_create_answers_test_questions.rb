Sequel.migration do
  change do
    create_table :answers_test_questions do
      foreign_key :answer_id, 			:answers, 			    null: false, on_delete: :cascade
      foreign_key :test_question_id, 	:test_questions, 	null: false, on_delete: :cascade
      index [:answer_id, :test_question_id], unique: true
    end
  end
end
