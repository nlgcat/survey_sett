Sequel.migration do
  change do
    create_table :consent_statements do
      # Keys
      primary_key :id

      # Data
      String :statement_name, null: false
      String :text, null: false
      
      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:statement_name], unique: true
    end
  end
end
