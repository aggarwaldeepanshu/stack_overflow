RSpec.describe Question, type: :model do

	let(:user) do
		User.new
	end
	subject do
		user.questions.build({ title: 'my title', body: 'body of question' })
	end

	describe 'Validations' do
		#Basic Validations
		it 'title should be present' do
			expect(subject).to validate_presence_of(:title)
		end

		it 'content should be present' do
			expect(subject).to validate_presence_of(:body)
		end

		#Inclusion/acceptance of values
		it 'title length must be atmost 100' do
			expect(subject).to validate_length_of(:title).is_at_most(100)
		end

		it 'content length must be atmost 500' do
			expect(subject).to validate_length_of(:body).is_at_most(500)
		end
	end

	describe 'Associations' do
		# question belongs to a user
    it 'question belongs to a user' do
    	expect(subject).to belong_to(:user)
    end

    #question has_many answers
    it 'question has many answers' do
    	expect(subject).to have_many(:answers).dependent(:destroy)
    end

    #question has_one question_vote
    it 'question has many answers' do
    	expect(subject).to have_one(:question_vote).dependent(:destroy)
    end
	end
end
