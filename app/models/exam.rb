class Exam < ApplicationRecord
  
  # associations
  has_many :subjects

  # validations
  validates_uniqueness_of :title, :case_sensitive => false
  validates_presence_of [ :title ]
end
