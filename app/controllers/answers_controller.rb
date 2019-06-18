class AnswersController < ApplicationController

  before_action :set_question, except: [:new, :create]
  before_action :check_access
  before_action :user, only: [:new, :create]
  before_action :find_question, only: [:new, :create]

  def new
    @answer = @question.answers.build
    @answer.build_answer_vote
  end

  def create
    @answer = @question.answers.new(create_params)
    @answer.save!
    redirect_to question_path(@question)
  end

  def edit
    answer
  end

  def update
    answer
    check_params
    question.update!(create_params)
    redirect_to question_path(@question)
  end

  def destroy
    question
    answer.destroy
    redirect_to question_path(@question)
  end

  private

  def user
    @user ||= current_user
  end

  def find_question
    @question ||= Question.find(params[:question_id])
  end

  def answer
    @answer ||= Answer.find(params[:id])
  end

  def question
    @question ||= answer.question_id
  end

  def answers
  	@answer ||= question.answers
  end

  def create_params
  	params.require(:answer).permit(:body, :user_id, :answer_vote_attributes)
  end

  def check_params
    param! params[:answer], Hash do |ques|
      ques.param! :body, String, required: true, max: 500
    end
  end
end
