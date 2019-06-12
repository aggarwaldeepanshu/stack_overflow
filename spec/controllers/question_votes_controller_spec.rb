RSpec.describe QuestionVotesController, type: :controller do
	let(:user) do
		create(:user)
	end

	let(:ques) do
		user.questions.create("title" => "title", "body" => "content")
	end

	let(:vote) do
		ques.create_question_vote("count" => 0)
	end

	subject(:ques_path) do
		expect(response).to redirect_to ques
	end

	describe 'upvote' do
		before(:each) { get :ques_upvote, params: {question_id: ques, id: vote } }
		it { ques_path }
	end

	describe 'downvote' do
		before(:each) { get :ques_downvote, params: {question_id: ques, id: vote } }
		it { ques_path }
	end
end
