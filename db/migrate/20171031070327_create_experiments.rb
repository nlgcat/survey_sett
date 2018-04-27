Sequel.migration do
  change do
    create_table :experiments do
      # Keys
      primary_key :id

      # Data
      DateTime :start_date, null: false
      DateTime :end_date, null: false
      Boolean  :completed, null: false, default: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      index [:start_date]
      index [:end_date]
      index [:completed]
    end
  end
end
