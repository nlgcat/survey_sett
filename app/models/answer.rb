class Answer < Sequel::Model
  plugin :timestamps, update_on_create: true
  many_to_many :questions
  many_to_many :test_questions
end
