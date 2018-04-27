Sequel.migration do
  change do
    create_table :explainer_images do
      # Keys
      primary_key :id

      # Data
      String    :url,         null: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:url], unique: true
    end
  end
end
