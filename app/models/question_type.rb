class QuestionType < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :questions

  CHECK     = 'Check'
  LIKERT    = 'Likert'
  MULTIPLE  = 'Multiple'

  def self.type_id t
    self.find(name: t).id
  end

  def self.get_id_from_name name
    find(name: name).id
  end

  def self.limits
    limits = {}
    QuestionType.all.each do |question_type|
      limits[question_type.id] = question_type.quantity_required
    end
    limits
  end
end
