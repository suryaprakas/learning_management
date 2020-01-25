class Subject < ApplicationRecord
 
  # associations
  has_many :topics
  belongs_to :exam

  # validations
  validates_presence_of [ :title, :exam_id ]

  def self.get_subject_ids(exam_ids)
    return Subject.where(exam_id: exam_ids).pluck(:id)
  end
end
