RSpec.describe AnswerVote, type: :model do
	let(:user) do
		User.new
	end

	let(:ques) do
		user.questions.new
	end

	let(:ans) do
		ques.answers.new
	end

	subject do
		ans.build_answer_vote( { count: 0 } )
	end

	describe 'Associations' do
		# question_vote belongs to a question
    it { should belong_to(:answer) }
	end
end
