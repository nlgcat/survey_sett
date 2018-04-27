Sequel.migration do
  change do
    create_table :explainer_categories do
      # Keys
      primary_key :id

      # Data
      String  :name,          null: false
      String  :description,   null: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:name],    unique: true
    end
  end
end
