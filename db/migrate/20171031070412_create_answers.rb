Sequel.migration do
  change do
    create_table :answers do
      # Keys
      primary_key :id

      # Data
      String  :value,         null: false
      Boolean :correct,       null: false, default: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:correct]
    end
  end
end
