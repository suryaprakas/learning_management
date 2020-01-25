class Chapter < ApplicationRecord

  # associations
  has_many :questions
  belongs_to :topic

  # validations
  validates_presence_of [ :name, :topic_id ]

  def get_unattempted_questions(user)
    total_question_ids = self.questions.pluck(:id)
    unattempted_question_ids = user.get_user_unattempted_questions(total_question_ids)
    return Question.where(id: unattempted_question_ids).order("RANDOM()")
  end

  def self.get_chapter_ids(topic_ids)
    return Chapter.where(topic_id: topic_ids).pluck(:id)
  end
end
