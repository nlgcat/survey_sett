Sequel.migration do
  change do
    create_table :participants do
      # Keys
      primary_key :id

      # Data
      String  :uid,             null: false
      Boolean :final_consent,   null: false, default: false
      Boolean :native,          null: false, default: false

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:uid], unique: true
      index [:final_consent]
      index [:native]
    end
  end
end
