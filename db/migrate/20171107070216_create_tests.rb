Sequel.migration do
  change do
    create_table :tests do
      # Keys
      primary_key :id
      foreign_key :participant_id,  :participants,  null: false, on_delete: :cascade
      foreign_key :statement_id,    :statements,    null: false, on_delete: :cascade

      # Data
      Boolean :statement_read,  null: false, default: false
      Boolean :statement_shown, null: false, default: false
      Boolean :completed,       null: false, default: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:participant_id, :statement_id], unique: true
      index [:statement_read]
      index [:statement_shown]
      index [:completed]
    end
  end
end
