RSpec.describe AnswersController, type: :controller do
  let(:user) do
  	create(:user)
  end

  let(:ques) do
    user.questions.create({ title: 'question title', body: 'question body' })
  end

  subject(:ans) do
  	ques.answers.create({ body: 'answer body' })
  end

  describe '#New' do 
    before(:each) { get :new, params: { question_id: ques } }
    it { expect(response).to have_http_status(:success) }
  end

  describe '#Create' do    
    it { expect{ answers('answer body') }.to change(Answer, :count).by(1) }
    it { expect{ answers() }.to_not change(Answer, :count) }
    it 'redirects to question page after creating' do
      redirect_to ques
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#Edit' do
    before(:each) { get :edit, params: {question_id: ques, id: subject } }
    it { expect(response).to have_http_status(:success) }
  end

  describe '#Update' do
    let(:a) do
      { :body => "new body" }
    end

    before(:each) do
      put :update, params: { :question_id => ques, :id => subject, :answer => a }
      subject.reload
    end

    it { expect(subject.body).to eql ans[:body] }
    it { expect(response).to redirect_to ques }
  end

  describe '#Destroy' do
    it 'count decreases by 1 after deleting' do
      temp = answers('test body')
      expect{ delete :destroy, params: { :question_id => ques, :id => temp} }.to change(Answer, :count).by(-1)
    end

    it 'redirects to user page after deleting' do
      redirect_to ques
      expect(response).to have_http_status(:ok)
    end
  end
end

private

def answers(body = ' ')
	ques.answers.create({ body: body })
end