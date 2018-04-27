Sequel.migration do
  change do
    create_table :explainers do
      # Keys
      primary_key :id
      foreign_key :explainer_category_id, :explainer_categories, null: false

      # Data

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      
    end
  end
end
