RSpec.describe QuestionVote, type: :model do
	let(:user) do
		User.new
	end

	let(:ques) do
		user.questions.new
	end

	subject do
		ques.build_question_vote( { count: 0 } )
	end

	describe 'Associations' do
		# question_vote belongs to a question
    it 'question_vote belongs to a question' do
    	expect(subject).to belong_to(:question)
    end
	end
end
