class Question < Sequel::Model
  plugin            :timestamps, update_on_create: true
  many_to_one       :question_type
  many_to_one       :question_format
  one_through_one   :statement
  many_to_many      :answers
end
