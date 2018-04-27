Sequel.migration do
  change do
    create_table :explainer_images_explainers do
      foreign_key :explainer_id,        :explainers,        null: false
      foreign_key :explainer_image_id,  :explainer_images,  null: false
      index [:explainer_id, :explainer_image_id], unique: true
    end
  end
end
