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

  let(:invalid_title) do
    { title: get_invalid_title, body: 'new body' }
  end

  let(:invalid_content) do
    { title: 'title', body: get_invalid_content }
  end

  let(:content) do
    { title: 'new title', body: 'new body' }
  end

  let(:login) do
    sign_in user
  end

  subject do
    #create(:question, user: user, title: 'question title', body: 'question body')
    create(:question, user: user, title: content[:title], body: content[:body])
  end

  describe '#Index' do
    before(:each) { get :index }
    it 'successfully redirects to index page' do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#Show' do
    it 'successfully redirects to question\'s show page' do
      login
      get :show, params: { id: subject }
      expect(response).to have_http_status(:success)
    end

    context 'Do not show the page if' do
      it 'user is not logged in' do
        expect{ get :show, params: { id: subject } }.to raise_error RuntimeError
      end
    end
  end

  describe '#New' do 
    it 'successfully redirects to new page' do
      get :new, params: { user_id: user }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#Create' do 
    context 'before creating' do
      before(:each) do
        login
      end
      it 'check if correct number of arguments passed' do
        expect{ subject }.to_not raise_error ArgumentError
      end
    end

    context 'after successfully creating a question' do
      before(:each) do
        login
      end
      it 'check if count increments by 1' do
        expect{ subject }.to change(Question, :count).by(1)
      end

      it 'it should redirect to user\'s show page' do
        redirect_to user
        expect(response).to have_http_status(:ok)
      end
    end

    context 'raise error if' do
      it 'user is not logged in' do
        expect{ post :create, params: { user_id: user, question: subject } }.to raise_error RuntimeError
      end
    end

    context 'renders \'new\' template for ' do
      before(:each) do
        login
      end
      it 'invalid title' do
        post :create, params: { user_id: user, question: invalid_title }
        expect(response).to render_template :new
      end

      it 'invalid content' do
        post :create, params: { user_id: user, question: invalid_content }
        expect(response).to render_template :new
      end
    end

    context 'does not increment questions count on passing' do
      before(:each) do
        login
      end
      it 'no arguments' do
        expect{ content.except(:title, :body) }.to_not change(Question, :count)
      end

      it 'empty content' do
        expect{ content.except(:body) }.to_not change(Question, :count)
      end

      it 'empty title' do
        expect{ content.except(:title) }.to_not change(Question, :count)
      end
    end
  end

  describe '#Edit' do
    it 'successfully redirects to edit page' do
      login
      get :edit, params: {user_id: user, id: subject }
      expect(response).to have_http_status(:success)
    end

    context 'Raise error if' do
      it 'user is not logged in' do
        expect{ get :edit, params: {user_id: user, id: subject } }.to raise_error RuntimeError
      end
    end    
  end

  describe '#Update' do
    context 'After update action' do
      before(:each) do
        login
        put :update, params: { user_id: user, id: subject, question: content }
        subject.reload
      end

      it 'check if arguments updated successfully' do
        expect(subject.title).to eql content[:title]
        expect(subject.body).to eql content[:body]
      end

      it 'successfully redirects to user\'s page' do
        expect(response).to redirect_to user
      end
    end

    context 'raise error if' do
      it 'user is not logged in' do
        expect{ put :update, params: { user_id: user, id: subject, question: content } }.to raise_error RuntimeError
      end

      context 'Title' do
        before(:each) do
          login
        end
        it 'is empty' do
          # empty_title = content
          # empty_title[:title] = ' '
          content[:title] = ''
          expect{ put :update, params: { user_id: user, id: subject, question: empty_title } }.to raise_error ActiveRecord::RecordInvalid
        end

        it 'has more than 100 characters' do
          expect{ put :update, params: { user_id: user, id: subject, question: invalid_title } }.to raise_error RuntimeError
        end
      end

      context 'Content' do
        before(:each) do
          login
        end
        it 'is empty' do
          empty_body = content
          empty_body[:body] = ' '
          expect{ put :update, params: { user_id: user, id: subject, question: empty_body } }.to raise_error ActiveRecord::RecordInvalid
        end

        it 'has more than 500 characters' do
          expect{ put :update, params: { user_id: user, id: subject, question: invalid_content } }.to raise_error RuntimeError
        end
      end
    end
  end

  describe '#Destroy' do
    context 'after deleting an answer' do
      it 'check if count decreases by 1' do
        temp = subject
        new_user = user
        login
        expect{ delete :destroy, params: { :user_id => new_user, 
                                         :id => temp} }.to change(Question, :count).by(-1)
      end

      it 'it should redirect to user\'s show page' do
        redirect_to user
        expect(response).to have_http_status(:ok)
      end
    end

    context 'do not delete' do
      it 'when user is not logged in' do
        expect{ delete :destroy, params: { :user_id => user, :id => subject} }.to raise_error RuntimeError
      end
    end
  end
end