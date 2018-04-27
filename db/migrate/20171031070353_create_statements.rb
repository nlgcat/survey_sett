Sequel.migration do
  change do
    create_table :statements do
      # Keys
      primary_key :id
      foreign_key :experiment_id,     :experiments,     null: false

      # Data
      Boolean :assigned,      null: false, default: false
      Integer :test_order,    null: false, default: 0
      String  :value,         null: false, default: ''

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:assigned]
      index [:test_order]
      index [:experiment_id]
    end
  end
end
