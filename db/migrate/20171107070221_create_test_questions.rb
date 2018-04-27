Sequel.migration do
  change do
    create_table :test_questions do
      # Keys
      primary_key :id
      foreign_key :test_id, 		:tests, 	     null: false, on_delete: :cascade
      foreign_key :question_id, :questions, 	 null: false, on_delete: :cascade

      # Data

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:question_id]
      index [:test_id]
    end
  end
end
