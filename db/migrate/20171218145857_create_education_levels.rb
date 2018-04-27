Sequel.migration do
  change do
    create_table :education_levels do
      # Keys
      primary_key :id

      # Data
      String  :value,      null: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:value],    unique: true
    end
  end
end
