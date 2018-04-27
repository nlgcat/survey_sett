class QuestionFormat < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :questions

  LIKERT = 'Likert'

  def self.type_id t
    self.find(name: t).id
  end
end
