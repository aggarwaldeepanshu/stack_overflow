class QuestionVotesController < ApplicationController

  before_action :set_question

  def new
  end

  def upvote
  	@vote = @question.question_vote
  	@vote.count += 1
  	@vote.save
  	redirect_to question_path(@question)
  end

  def downvote
  	@vote = @question.question_vote
  	@vote.count -= 1
  	@vote.save
  	redirect_to question_path(@question)
  end


  private

  def set_question
  	@question = Question.find(params[:question_id])
  end
end
