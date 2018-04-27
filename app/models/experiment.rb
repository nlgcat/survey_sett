class Experiment < Sequel::Model
  plugin :timestamps, update_on_create: true
  one_to_many :experiment_iterations
  one_to_many :statements
end
