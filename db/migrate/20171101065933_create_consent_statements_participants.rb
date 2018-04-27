Sequel.migration do
  change do
    create_table :consent_statements_participants do
      foreign_key :consent_statement_id,  :consent_statements, null: false
      foreign_key :participant_id,        :participants,           null: false
      index [:consent_statement_id, :participant_id], unique: true
    end
  end
end
