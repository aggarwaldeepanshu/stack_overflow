class QuestionsController < ApplicationController

  

  before_action :set_user, except: [:index, :show]
  #after_create :create_vote

  def index
    #@questions = questions.limit(10)
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
    #@vote = @question.question_vote.where(question_id: params[:id])
    @vote = @question.question_vote
  end

  def new
  end

  def create
    #debugger
  	# @question = questions.create!(create_params)
   #  @question.create_question_vote(create_vote)
  	# redirect_to user_path(@user)

    if questions.create(create_params).valid?
      @question = Question.last
      @question.create_question_vote(create_vote)
      redirect_to user_path(@user)
    else
      render 'new'
    end

  end

  def edit
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

  def destroy
    @question = questions.find(params[:id])
    @question.destroy
    redirect_to user_path(@user)
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

  def create_vote
    my_params = ActionController::Parameters.new(question_id: @question, count: 0)
    my_params.permit(:question_id, :count)
  end
end
