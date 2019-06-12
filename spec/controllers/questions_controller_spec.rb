RSpec.describe QuestionsController, type: :controller do
  let(:user) do
    create(:user)
  end

  subject do
    user.questions.create({ title: 'question title', body: 'question body' })
  end

  describe '#Index' do
    before(:each) { get :index }
    it { expect(response).to have_http_status(:success) }
  end

  describe '#Show' do
    before(:each) { get :show, params: { id: subject }}
    it { expect(response).to have_http_status(:success) }
  end

  describe '#New' do 
    before(:each) { get :new, params: { user_id: user } }
    it { expect(response).to have_http_status(:success) }
  end

  describe '#Edit' do
    before(:each) { get :edit, params: {user_id: user, id: subject } }
    it { expect(response).to have_http_status(:success) }
  end
    
  describe '#Create' do    
    it { expect{ questions('question title', 'question body') }.to change(Question, :count).by(1) }
    it { expect{ questions() }.to_not change(Question, :count) }
    it 'redirects to user page after creating' do
      redirect_to user
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#Update' do
    let(:ques) do
      { :title => 'new title', :body => 'new body' }
    end

    before(:each) do
      put :update, params: { :user_id => user, :id => subject, :question => ques }
      subject.reload
    end

    it { expect(response).to redirect_to user }
    it { expect(subject.title).to eql ques[:title] }
    it { expect(subject.body).to eql ques[:body] }
  end

  describe '#Destroy' do
    it 'count decreases by 1 after deleting' do
      temp = questions('test title', 'test body')
      expect{ delete :destroy, params: { :user_id => user, :id => temp} }.to change(Question, :count).by(-1)
    end

    it 'redirects to user page after deleting' do
      redirect_to user
      expect(response).to have_http_status(:ok)
    end
  end
end

private

def questions(title = ' ', content = ' ')
  user.questions.create({ 'title' => title, 
                            'body' => content })
end