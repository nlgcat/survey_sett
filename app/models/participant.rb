class Participant < Sequel::Model
  plugin          :timestamps, update_on_create: true
  one_through_one :gender
  many_to_many    :consent_statements
  one_to_many     :tests
  one_through_one :education_level

  def consented?
    ConsentStatement.all.each do |consent_statement|
      return false if consent_statements(consent_statement_id: consent_statement.id).empty?
    end
    true
  end
end
