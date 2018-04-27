Sequel.migration do
  change do
    create_table :education_levels_participants do
      foreign_key :education_level_id,  :education_levels,  null: false
      foreign_key :participant_id,      :participants,      null: false
      index [:education_level_id, :participant_id], unique: true
    end
  end
end
