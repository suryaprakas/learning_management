class Answer < ApplicationRecord
 
  # associations
  belongs_to :user
  belongs_to :question

  # validations
  validates_presence_of [ :answer, :question_id, :user_id, :option_id ]
  
  # class methods
  def self.calculate_user_percenatge(params, user)
    percentage_details = []
    if params[:exam_id].present?
      subject_ids = Subject.get_subject_ids(params[:exam_id])
      topic_ids = Topic.get_topic_ids(subject_ids)
      chapter_ids = Chapter.get_chapter_ids(topic_ids)
      total_question_ids = Question.get_question_ids(chapter_ids)
      attempted_question_ids, unattempted_question_ids, skipped_question_ids = user.get_user_questions_details(total_question_ids)
      percentage_details << { attempted_question_count: attempted_question_ids.count, unattempted_question_count: unattempted_question_ids.count, skipped_question_count: skipped_question_ids.count, correct_question_count: user.get_user_correct_questions(total_question_ids).count, incorrect_question_count: user.get_user_incorrect_questions(total_question_ids).count }
      percentage_details << Question.get_total_percentage(attempted_question_ids, unattempted_question_ids, skipped_question_ids, total_question_ids)
    elsif params[:subject_id].present?
      topic_ids = Topic.get_topic_ids(params[:subject_id])
      chapter_ids = Chapter.get_chapter_ids(topic_ids)
      total_question_ids = Question.get_question_ids(chapter_ids)
      attempted_question_ids, unattempted_question_ids, skipped_question_ids = user.get_user_questions_details(total_question_ids)
      percentage_details << { attempted_question_count: attempted_question_ids.count, unattempted_question_count: unattempted_question_ids.count, skipped_question_count: skipped_question_ids.count, correct_question_count: user.get_user_correct_questions(total_question_ids).count, incorrect_question_count: user.get_user_incorrect_questions(total_question_ids).count }
      percentage_details << Question.get_total_percentage(attempted_question_ids, unattempted_question_ids, skipped_question_ids, total_question_ids)
    elsif params[:topic_id].present?
      chapter_ids = Chapter.get_chapter_ids(params[:topic_id])
      total_question_ids = Question.get_question_ids(chapter_ids)
      attempted_question_ids, unattempted_question_ids, skipped_question_ids = user.get_user_questions_details(total_question_ids)
      percentage_details << { attempted_question_count: attempted_question_ids.count, unattempted_question_count: unattempted_question_ids.count, skipped_question_count: skipped_question_ids.count, correct_question_count: user.get_user_correct_questions(total_question_ids).count, incorrect_question_count: user.get_user_incorrect_questions(total_question_ids).count }
      percentage_details << Question.get_total_percentage(attempted_question_ids, unattempted_question_ids, skipped_question_ids, total_question_ids)
    else
      total_question_ids = Question.get_question_ids(params[:chapter_id])
      attempted_question_ids, unattempted_question_ids, skipped_question_ids = user.get_user_questions_details(total_question_ids)
      percentage_details << { attempted_question_count: attempted_question_ids.count, unattempted_question_count: unattempted_question_ids.count, skipped_question_count: skipped_question_ids.count, correct_question_count: user.get_user_correct_questions(total_question_ids).count, incorrect_question_count: user.get_user_incorrect_questions(total_question_ids).count }
      percentage_details << Question.get_total_percentage(attempted_question_ids, unattempted_question_ids, skipped_question_ids, total_question_ids)
    end
    percentage_details
  end

  

  

  

end
