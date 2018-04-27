Sequel.migration do
  change do
    create_table :questions do
      # Keys
      primary_key :id
      foreign_key :question_type_id,    :question_types,    null: false
      foreign_key :question_format_id,  :question_formats,  null: false

      # Data
      String  :value,         null: false
      Integer :layer,         null: false, default: 0

      # Timestamps
      DateTime  :created_at,  null: false
      DateTime  :updated_at,  null: false

      # Index
      index [:question_type_id]
      index [:layer]
    end
  end
end
