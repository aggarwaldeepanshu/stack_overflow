module VotesService
	class VoteManager

		def intialize(entity: )
			self.entity = entity
		end

		private

		attr_accessor :entity


		def upvote
			vote = entiry.up_vote
  		vote.count += 1
  		vote.save!
		end

		def self.ques_downvote(question)
			vote = question.question_vote
  		vote.count -= 1
  		vote.save!
		end

		def self.ans_upvote(answer)
			vote = answer.answer_vote
  		vote.count += 1
  		vote.save!
		end

		def self.ans_downvote(answer)
			vote = answer.answer_vote
  		vote.count -= 1
  		vote.save!
		end
	end
end