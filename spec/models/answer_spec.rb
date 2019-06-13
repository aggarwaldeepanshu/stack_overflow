RSpec.describe Answer, type: :model do
	let(:user) do
		User.new
	end

	let(:ques) do
		user.questions.new
	end

	subject do
		ques.answers.build( { body: 'my answer' } )
	end

	describe 'Validations' do
		#Basic Validations
		it { expect(subject).to validate_presence_of(:body) }

		#Inclusion/acceptance of values
		it { expect(subject).to validate_length_of(:body).is_at_most(700)}
	end

	describe 'Associations' do
		# answer belongs to a question
    it { expect(subject).to belong_to(:question) }

    #answer has_one answer_vote
    it { expect(subject).to have_one(:answer_vote).dependent(:destroy) }
	end
end
