class Topic < ApplicationRecord

  # associations
  has_many :chapters
  belongs_to :subject

  # validations
  validates_presence_of [ :name, :subject_id ]

  def self.get_topic_ids(subject_ids)
    return Topic.where(subject_id: subject_ids).pluck(:id)
  end
end
