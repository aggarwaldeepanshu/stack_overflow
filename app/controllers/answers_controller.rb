class AnswersController < ApplicationController

  before_action :set_question

  def create
    if user_signed_in?
      if answers.create(create_params).valid?
        @answer = Answer.last
        @answer.create_answer_vote(create_vote)
        redirect_to question_path(@question)
      else
        raise 'Invalid content'
      end
    else
      raise 'Please login/invalid question'
    end
  end

  def edit
    if user_signed_in?
      @answer = answers.find(params[:id])
    else
      raise 'Please login first'
    end
  end

  def update
    if user_signed_in?
      @answer = answers.find(params[:id])
      if @answer.update(create_params)
  		  redirect_to question_path(@question)
      else
        raise 'Invalid content'
  		  render 'edit'
      end
    else
      raise 'Please login first'
    end
  end

  def destroy
    if user_signed_in?
      @answer = answers.find(params[:id])
      @answer.destroy
      redirect_to question_path(@question)
    else
      raise 'Please login first'
    end
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
  	params.require(:answer).permit('body')
  end

  def create_vote
    my_params = ActionController::Parameters.new(answer_id: @answer, count: 0)
    my_params.permit(:answer_id, :count)
  end
end
