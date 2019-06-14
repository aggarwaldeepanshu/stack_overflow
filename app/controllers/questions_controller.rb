class QuestionsController < ApplicationController

  before_action :set_user, except: [:index, :show]
  before_action :check_params, only: [:update]
  #before_action :authenticate_user!, only: [:destroy]
  #after_create :create_vote

  def index
    @questions = Question.all
  end

  def show
    if user_signed_in?
      @question = Question.find(params[:id])
      @vote = @question.question_vote
    else
      raise 'Please login first'
    end
  end

  def new
  end

  def create
    if user_signed_in?
      if questions.create(create_params).valid?
        @question = Question.last
        @question.create_question_vote(create_vote)
        redirect_to user_path(@user)
      else
        render 'new'
      end
    else
      raise 'Please login first'
    end
  end

  def edit
    if user_signed_in?
      @question = questions.find(params[:id])
    else
      raise 'Please login first'
    end
  end

  def update
    if user_signed_in?
      @question = questions.find(params[:id])
      if @question.update(create_params)
        redirect_to @user
      else
        render 'edit'
      end
    else
      raise 'Please login first'
    end
  end

  def destroy
    if user_signed_in?
      @question = questions.find(params[:id])
      @question.destroy
      redirect_to user_path(@user)
    else
      raise 'Please login first'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
    #@user = current_user
  end

  def questions
    @user.questions
  end

  def create_params
    params.require(:question).permit(:title, :body)
  end

  def check_params
    raise 'title cannot be empty' if params[:question][:title].empty?
    raise 'title cannot have more than 100 characters' if params[:question][:title].length > 100
    raise 'content cannot be empty' if params[:question][:body].empty?
    raise 'content cannot have more than 500 characters' if params[:question][:body].length > 500
  end

  def create_vote
    my_params = ActionController::Parameters.new(question_id: @question, count: 0)
    my_params.permit(:question_id, :count)
  end
end
