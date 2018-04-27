Sequel.migration do
  change do
    create_table :explainer_texts_explainers do
      foreign_key :explainer_id,      :explainers,      null: false
      foreign_key :explainer_text_id, :explainer_texts, null: false
      index [:explainer_id, :explainer_text_id], unique: true
    end
  end
end
