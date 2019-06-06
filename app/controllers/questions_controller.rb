class QuestionsController < ApplicationController

  

  before_action :set_user, except: [:index]

  def index
    #@questions = questions.limit(10)
    @questions = Question.all
  end

  def show
  end

  def new
  end

  def create
  	questions.create!(create_params)
  	redirect_to user_path(@user)
  end

  def edit
    #debugger
    @question = questions.find(params[:id])
  end

  def update
    @question = questions.find(params[:id])
    if @question.update(create_params)
      redirect_to @user

    else
      render 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def questions
    @user.questions
  end

  def create_params
    params.require(:question).permit(:title, :body)
  end
end
