class QuestionFormat < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :questions

  LIKERT    = 'Likert'
  MULTIPLE  = 'Multiple'

  def self.type_id t
    self.find(name: t).id
  end

  def to_sym
    self.view.to_sym
  end
end
