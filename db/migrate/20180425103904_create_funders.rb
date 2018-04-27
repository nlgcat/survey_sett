Sequel.migration do
  change do

    create_table :funders do
      primary_key :id
    end

  end
end
