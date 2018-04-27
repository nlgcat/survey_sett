Sequel.migration do
  change do
    create_table :answers_participant do
      foreign_key :answer_id,       :answers,       null: false, on_delete: :cascade
      foreign_key :participant_id,  :participants,  null: false, on_delete: :cascade
      index [:answer_id], unique: true
      index [:participant_id], unique: true
    end
  end
end
