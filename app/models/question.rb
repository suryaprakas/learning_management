class Question < ApplicationRecord
  
  # associations
  has_many :options
  belongs_to :chapter

  # validations
  validates_presence_of [ :title, :chapter_id, :question_type ]

  enum question_type: [:easy, :medium, :hard]
  module QuestionType
    EASY = 'easy'
    MEDIUM = 'medium'
    HARD = 'hard'
  end

  def check_visibility?(user)
    return Answer.where(user: user.id, is_skipped: false, question_id: self.id).exists?
  end

  def self.get_question_ids(chapter_ids)
    return Question.where(chapter_id: chapter_ids).pluck(:id)
  end

  def self.calculate_percentage(questions, total_questions)
    return (questions.count.to_f/total_questions.count.to_f) * 100
  end

  def self.get_total_percentage(attempted_question_ids, unattempted_question_ids, skipped_question_ids, total_question_ids)
    hash = {}
    hash[:attempted_question_percentage] = Question.calculate_percentage(attempted_question_ids, total_question_ids)
    hash[:unattempted_question_percentage] = Question.calculate_percentage(unattempted_question_ids, total_question_ids)
    hash[:skipped_question_percentage] = Question.calculate_percentage(skipped_question_ids, total_question_ids)
    hash
  end
  
end
