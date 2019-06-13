class AnswersController < ApplicationController

  before_action :set_question

  def new
  end

  def create
  	#debugger
  	@answer = answers.create!(create_params)
    @answer.create_answer_vote(create_vote)
  	redirect_to question_path(@question)
  end

  def edit
    debugger
  	@answer = answers.find(params[:id])
  end

  def update
  	@answer = answers.find(params[:id])
  	if @answer.update(create_params)
  		redirect_to question_path(@question)
  	else
  		render 'edit'
  	end
  end

  def destroy
    @answer = answers.find(params[:id])
    @answer.destroy
    redirect_to question_path(@question)
  end


  def upvote

  end


  def downvote

  end

  private

  def set_question
  	@question = Question.find(params[:question_id])
  end

  def answers
  	@question.answers
  end

  def create_params
  	params.require(:answer).permit("body")
  end

  def create_vote
    my_params = ActionController::Parameters.new(answer_id: @answer, count: 0)
    my_params.permit(:answer_id, :count)
  end
end
