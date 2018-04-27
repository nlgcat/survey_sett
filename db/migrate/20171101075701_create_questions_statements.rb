Sequel.migration do
  change do
    create_table :questions_statements do
      foreign_key :statement_id, :statements, null: false, on_delete: :cascade
      foreign_key :question_id,  :questions,  null: false, on_delete: :cascade
      index [:statement_id]
      index [:question_id]
    end
  end
end
