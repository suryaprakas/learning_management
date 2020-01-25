class Api::V1::QuestionsController < ApplicationController
    swagger_controller :questions, 'Questions Management'

    swagger_api :list do
      summary 'Shows questions within a chapter or topic or subject or Exam.'
      param :query, :exam_id, :integer, :optional, 'Exam ID'
      param :query, :subject_id, :integer, :optional, 'Subject ID'
      param :query, :topic_id, :integer, :optional, 'Topic Id'
      param :query, :chapter_id, :integer, :optional, 'Chapter Id'
    end

    def list
      if params[:exam_id].present?
        @exam = Exam.find_by_id(params[:exam_id])
        render 'api/v1/exams/show', status: :ok
      elsif params[:subject_id].present?
        @subject = Subject.find_by_id(params[:subject_id])
        render 'api/v1/subjects/show', status: :ok
      elsif params[:topic_id].present?
        @topic = Topic.find_by_id(params[:topic_id])
        render 'api/v1/topics/show', status: :ok
      elsif params[:chapter_id].present?
        @chapter = Chapter.find_by_id(params[:chapter_id])
        render 'api/v1/chapters/show', status: :ok
      end
    end

    swagger_api :calculate_percenatge do
      summary 'Shows users percentages within a chapter or topic or subject or Exam.'
      param :query, :exam_id, :integer, :optional, 'Exam ID'
      param :query, :subject_id, :integer, :optional, 'Subject ID'
      param :query, :topic_id, :integer, :optional, 'Topic Id'
      param :query, :chapter_id, :integer, :optional, 'Chapter Id'
    end

    def calculate_percenatge
      @calculate_percenatge = Answer.calculate_user_percenatge(params, current_user)
      render json: {details: @calculate_percenatge}, status: :ok
    end

    private

    def answer_params
      params.require(:answer).permit(:question_id, :is_skipped, :option_id)
    end

    def check_question_answered?
      return Answer.where(question_id: param[:question_id], is_skipped: false, user_id: current_user.id).exists?
    end
end
