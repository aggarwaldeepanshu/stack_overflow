RSpec.describe QuestionsController, type: :controller do
  let(:user) do
    create(:user)
  end

  let(:get_invalid_title) do
    'a'*101
  end

  let(:get_invalid_content) do
    'b'*501
  end

  subject do
    user.questions.create({ title: 'question title', body: 'question body' })
    #create(:question, { title: 'question title', body: 'question body' })
  end

  describe '#Index' do
    before(:each) { get :index }

    context 'Positive cases' do
      it 'successfully redirects to index page' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#Show' do
    before(:each) { get :show, params: { id: subject } }

    context 'Positive cases' do
      it 'successfully redirects to question\'s show page' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#New' do 
    before(:each) { get :new, params: { user_id: user } }
    
    context 'Positive cases' do
      it 'successfully redirects to new page' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#Create' do 
    let(:invalid_title) do
      { :title => get_invalid_title, :body => 'new body' }
    end
    let(:invalid_content) do
      { :title => 'title', :body => get_invalid_content }
    end

    context 'Positive cases' do
      it 'redirects to user page after creating a question' do
        redirect_to user
        expect(response).to have_http_status(:ok)
      end

      it 'check if correct arguments passed' do
        expect{ questions('title', 'content') }.to_not raise_error ArgumentError
      end

      it 'increments number of questions by 1 after successful creation' do
        expect{ questions('question title', 'question body') }.to change(Question, :count).by(1)
      end
    end

    context 'Negative cases' do
      it 'does not increment questions count on passing invalid attributes' do
        expect{ questions() }.to_not change(Question, :count)
        expect{ questions('title') }.to_not change(Question, :count)
        expect{ questions(' ', 'content') }.to_not change(Question, :count)
      end

      it 'renders new template for invalid title' do
        post :create, params: { user_id: user, question: invalid_title }
        expect(response).to render_template :new
      end

      it 'renders new template for invalid content' do
        post :create, params: { user_id: user, question: invalid_content }
        expect(response).to render_template :new
      end
    end
  end

  describe '#Edit' do
    before(:each) { get :edit, params: {user_id: user, id: subject } }
    
    context 'Positive cases' do
      it 'successfully redirects to edit page' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe '#Update' do
    let(:ques) do
      { :title => 'new title', :body => 'new body' }
    end

    context 'Positive cases' do
      before(:each) do
        put :update, params: { :user_id => user, :id => subject, :question => ques }
        subject.reload
      end

      it 'successfully redirects to user\'s page' do
        expect(response).to redirect_to user
      end

      it 'check if arguments updated successfully' do
        expect(subject.title).to eql ques[:title]
        expect(subject.body).to eql ques[:body]
      end
    end
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