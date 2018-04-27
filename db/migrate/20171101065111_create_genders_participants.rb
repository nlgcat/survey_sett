Sequel.migration do
  change do
    create_table :genders_participants do
      foreign_key :gender_id,       :genders,   null: false
      foreign_key :participant_id,  :participants,  null: false
      index [:gender_id, :participant_id], unique: true
    end
  end
end
