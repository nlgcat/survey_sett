class TestQuestion < Sequel::Model
	plugin :timestamps, update_on_create: true
	many_to_one :test
	many_to_one :question
	many_to_many :answers
end
