RSpec.describe VotesService, type: :service do
	let(:user) do
		create(:user)
	end

	let(:ques) do
		user.questions.create(title: 'title', body: 'content')
	end

	let(:ques_vote) do
		ques.create_question_vote(count: 0)
	end

	let(:answer) do
		ques.answers.create(body: 'answer body')
	end

	let(:ans_vote) do
		answer.create_answer_vote(count: 0)
	end

	describe 'question' do
		context '.ques_upvote' do
			it 'should increment question vote count by 1' do
				ques_vote
				expect { VotesService.ques_upvote(ques) }.to change(ques_vote, :count).by(1)
			end
		end

		context '.ques_downvote' do
			it 'should decrement question vote count by 1' do
				ques_vote
				expect { VotesService.ques_downvote(ques) }.to change(ques_vote, :count).by(-1)
			end
		end
	end

	describe 'answer' do
		context '.ans_upvote' do
			it 'should increment answer vote count by 1' do
				ans_vote
				expect { VotesService.ans_upvote(answer) }.to change(ans_vote, :count).by(1)
			end
		end

		context '.ans_downvote' do
			it 'should decrement answer vote count by 1' do
				ans_vote
				expect { VotesService.ans_downvote(answer) }.to change(ans_vote, :count).by(-1)
			end
		end
	end
end