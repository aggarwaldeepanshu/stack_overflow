class AnswersController < ApplicationController

  before_action :set_question

  def new
  end

  def create
  	#debugger
  	@question.answers.create!(create_params)
  	redirect_to question_path(@question)
  end

  def edit
  	@answer = @question.answers.find(params[:id])
  end

  def update
  	@answer = @question.answers.find(params[:id])
  	if @answer.update(create_params)
  		redirect_to question_path(@question)
  	else
  		render 'edit'
  	end
  end

  private

  def set_question
  	@question = Question.find(params[:question_id])
  end

  def create_params
  	params.require(:answer).permit("body")
  end
end
