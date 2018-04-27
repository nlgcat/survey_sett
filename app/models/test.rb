class Test < Sequel::Model
	plugin :timestamps, update_on_create: true
	many_to_one :participant
	many_to_one :statement
	one_to_many :test_questions
end
