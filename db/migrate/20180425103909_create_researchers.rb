Sequel.migration do
  change do

    create_table :researchers do
      primary_key :id
    end

  end
end
