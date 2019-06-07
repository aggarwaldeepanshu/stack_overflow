module VotesService
	class << self
		def ques_upvote(question)
			@vote = question.question_vote
  			@vote.count += 1
  			@vote.save!
		end

		def ques_downvote(question)
			@vote = question.question_vote
  			@vote.count -= 1
  			@vote.save!
		end

		def ans_upvote(answer)
			@vote = answer.answer_vote
  			@vote.count += 1
  			@vote.save!
		end

		def ans_downvote(answer)
			@vote = answer.answer_vote
  			@vote.count -= 1
  			@vote.save!
		end
	end
end