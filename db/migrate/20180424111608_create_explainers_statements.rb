Sequel.migration do
  change do
    create_table :explainers_statements do
      foreign_key :explainer_id,  :explainers,  null: false
      foreign_key :statement_id,  :statements,  null: false
      index [:explainer_id, :statement_id], unique: true
    end
  end
end
