class QuestionType < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :questions

  WARMUP      = 'Warm-up'
  DISTRACTOR  = 'Distractor'
  CATEGORY_A  = 'Category A'
  CATEGORY_B  = 'Category B'
  CATEGORY_C  = 'Category C'

  def self.type_id t
    self.find(name: t).id
  end

  def self.get_id_from_name name
    find(name: name).id
  end

  def self.limits
    limits = {
        # get_id_from_name(WARMUP)      => 6,
        # get_id_from_name(DISTRACTOR)  => 4,
        get_id_from_name(CATEGORY_A)  => 6,
        # get_id_from_name(CATEGORY_B)  => 1,
        # get_id_from_name(CATEGORY_C)  => 1,
      }
  end
end
