class QuestionVotesController < ApplicationController

  before_action :set_question, only: [:ques_upvote, :ques_downvote]
  before_action :set_answer, only: [:ans_upvote, :ans_downvote]

  def new
  end

  def ques_upvote
    @vote = ::VotesService.ques_upvote(@question)
  	redirect_to question_path(@question)
  end

  def ques_downvote
    @vote = ::VotesService.ques_downvote(@question)
  	redirect_to question_path(@question)
  end

  def ans_upvote
    ::VotesService.ans_upvote(@answer)
    redirect_to question_path(@answer.question_id)
  end

  def ans_downvote
    ::VotesService.ans_downvote(@answer)
    redirect_to question_path(@answer.question_id)
  end

  private

  def set_question
  	@question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end
end
