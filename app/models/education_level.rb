class EducationLevel < Sequel::Model
  plugin :timestamps, update_on_create: true
  many_to_many :participants
end
