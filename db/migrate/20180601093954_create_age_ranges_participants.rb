Sequel.migration do
  change do
    create_table :age_ranges_participants do
      foreign_key :age_range_id,    :age_ranges,    null: false
      foreign_key :participant_id,  :participants,  null: false
      index [:age_range_id, :participant_id], unique: true
    end
  end
end
