Sequel.migration do
  change do
    create_table :question_formats do
      # Keys
      primary_key :id

      # Data
      String  :name,  null: false
      String  :view,  null: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:name], unique: true
      index [:view]
    end
  end
end
