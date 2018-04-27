class Answer < Sequel::Model
  plugin :timestamps, update_on_create: true
  many_to_many :questions
  one_through_one :test_question
end
