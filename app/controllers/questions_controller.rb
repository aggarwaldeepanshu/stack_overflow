class QuestionsController < ApplicationController

  before_action :check_access
  
  def index
    user
    @questions = Question.all
  end

  def show
    @vote = question.question_vote
  end

  def new
    user
    @question = Question.new
    @question.build_question_vote
  end

  def create
    @question = questions.new(create_params)
    @question.save!
    redirect_to user_path(user)
  end

  def edit
    question
  end

  def update
    check_params
    question.update_attributes!(update_params)
    redirect_to user
  end

  def destroy
    question.destroy
    redirect_to user_path(user)
  end

  private

  def user
    @user ||= current_user
  end

  def question 
    @question ||= questions.find(params[:id])
  end

  def questions
    @question ||= user.questions
  end

  def create_params
    params.require(:question).permit(:title, :body, :question_vote_attributes)
  end

  def check_params
    param! :question, Hash do |ques|
      ques.param! :title, String, required: true, max: 100
      ques.param! :body, String, required: true, max: 500
    end
  end
end
