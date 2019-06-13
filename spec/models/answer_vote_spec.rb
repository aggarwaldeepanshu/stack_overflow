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
		# answer_vote belongs to an answer
    it { expect(subject).to belong_to(:answer) }
	end
end
