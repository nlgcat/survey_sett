Sequel.migration do
  change do
    create_table :explainer_texts do
      # Keys
      primary_key :id

      # Data
      String    :text,        null: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:text]
    end
  end
end
