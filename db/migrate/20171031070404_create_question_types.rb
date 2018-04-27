Sequel.migration do
  change do
    create_table :question_types do
      # Keys
      primary_key :id

      # Data
      String  :name,              null: false
      Integer :quantity_required, null: false
      Boolean :live,              null: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:name]
      index [:quantity_required]
      index [:live]
    end
  end
end
