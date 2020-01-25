class Api::V1::AnswersController < ApplicationController

    before_action :check_question_answered?, only: [:create]

    swagger_controller :answers, 'Answers Management'

    swagger_api :create do
      summary 'Answer a particular question'
      param :form, :'answer[question_id]', :integer, :required, 'Question ID'
      param :form, :'answer[is_skipped]', :boolean, :required, 'Skipped or not'
      param :form, :'answer[option_id]', :integer, :required, 'Option Id'
    end

    def create
      @answer = Answer.new(answer_params)
      @answer.user_id = current_user.id
      option_correct?(@answer)
      if @answer.save!
        render :show, status: :ok
      else
        render 'api/v1/shared/model_errors', locals: { object: @cluster }, status: :bad_request
      end
    end

    private

    def answer_params
      params.require(:answer).permit(:question_id, :is_skipped, :option_id)
    end

    def check_question_answered?
      raise Lms::Exception::InvalidParameter.new(_('views.answers.already_answered')) if Answer.where(question_id: params[:answer][:question_id], is_skipped: false, user_id: current_user.id).exists?
    end

    def option_correct?(answer)
      correct_option = Option.where(question_id: answer.question_id, is_correct: true).first
      answer.is_answer_correct = correct_option.id == answer.option_id ? true : false
      answer
    end
end
