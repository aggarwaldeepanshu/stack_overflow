RSpec.describe Question, type: :model do

	let(:user) do
		User.new
	end
	subject do
		user.questions.build({ title: 'my title', body: 'body of question' })
	end

	describe 'Validations' do
		#Basic Validations
		it { expect(subject).to validate_presence_of(:title) }
		it { expect(subject).to validate_presence_of(:body)}

		#Inclusion/acceptance of values
		it { expect(subject).to validate_length_of(:title).is_at_most(100)}
		it { expect(subject).to validate_length_of(:body).is_at_most(500)}
	end

	describe 'Associations' do
		# question belongs to a user
    it { expect(subject).to belong_to(:user) }

    #question has_many answers
    it { expect(subject).to have_many(:answers).dependent(:destroy) }

    #question has_one question_vote
    it { expect(subject).to have_one(:question_vote).dependent(:destroy) }
	end
end
