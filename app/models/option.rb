class Option < ApplicationRecord

  # associations
  belongs_to :question
  # validations
  validates_presence_of [ :option, :is_correct, :question_id ]
end
