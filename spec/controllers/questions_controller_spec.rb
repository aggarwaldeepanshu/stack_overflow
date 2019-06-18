RSpec.describe QuestionsController, type: :controller do
  let(:user) do
    create(:user)
  end

  let(:content) do
    { title: 'new title', body: 'new body' }
  end

  let(:login) do
    sign_in user
  end

  describe '#Index' do
    before(:each) { get :index }
    it 'successfully redirects to index page' do
      expect(response).to have_http_status(:success)
    end
  end

  describe '#Show' do
    it 'raise error when user is not logged in' do
      expect{ get :show, params: { id: subject } }.to raise_error RuntimeError
    end

    it 'successfully redirects to question\'s show page' do
      login
      get :show, params: { id: subject }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#New' do 
    it 'successfully redirects to new page' do
      get :new, params: { user_id: user }
      expect(response).to have_http_status(:success)
    end
  end

  describe '#Create' do
    subject do
      create(:question, user: user, title: content[:title], body: content[:body])
    end

    context 'when not logged in' do
      it 'raise error if user is not logged in' do
        expect({ post :create, params: { user_id: user, question: content } }).to raise_error RuntimeError
      end
    end
    
    context 'when logged in' do
      before(:each) do
        login
      end

      context 'when invalid parameters' do
        it 'does not increment the questions count if any parameter is missing/empty' do
          expect{ content.except(:title, :body) }.to_not change(Question, :count)
          expect()
          expect{ content.except(:body) }.to_not change(Question, :count)
          expect{ content.except(:title) }.to_not change(Question, :count)
        end

        it 'displays \'new\' template when title exceeds maximum length' do
          content[:title] = 'a'*101
          post :create, params: { user_id: user, question: content }
          expect(response).to render_template :new
        end

        it 'displays \'new\' template when content exceeds maximum length' do
          content[:body] = 'b'*501
          post :create, params: { user_id: user, question: content }
          expect(response).to render_template :new
        end
      end

      context 'when valid parameters' do
        it 'increments questions count by 1' do
          expect{ subject }.to change(Question, :count).by(1)
        end

        # it 'redirects to user\'s show page' do
        #   redirect_to user
        #   expect(response).to have_http_status(:ok)
        # end
      end
    end
  end

  describe '#Edit' do
    it 'shows RuntimeError if user is not logged in' do
      expect{ get :edit, params: { user_id: user, id: subject } }.to raise_error RuntimeError
    end

    it 'displays edit page when user is logged in' do
      login
      get :edit, params: { user_id: user, id: subject }
      expect(response).to have_http_status(:success)
    end  
  end

  describe '#Update' do
    it 'raise Runtime error if user is not logged in' do
      expect{ put :update, params: { user_id: user, id: subject, question: content } }.to raise_error RuntimeError
    end

    context 'on passing invalid paramters' do
      before(:each) do
        login
      end

      it 'raise RecordInvalid error if title/content is either empty or exceed maximum size' do
        expect{ put :update, params: { user_id: user, id: subject, question: content.merge(title: '') } }.to raise_error ActiveRecord::RecordInvalid

        expect{ put :update, params: { user_id: user, id: subject, question: content.merge(body: '')} }.to raise_error ActiveRecord::RecordInvalid

        content[:title] = 'a'*101
        expect{ put :update, params: { user_id: user, id: subject, question: content } }.to raise_error ActiveRecord::RecordInvalid

        content[:body] = 'a'*501
        expect{ put :update, params: { user_id: user, id: subject, question: content } }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'on passing valid parameters' do
      before(:each) do
        login
        put :update, params: { user_id: user, id: subject, question: content }
        subject.reload
      end

      it 'should update the arguments' do
        expect(subject.title).to eql content[:title]
        expect(subject.body).to eql content[:body]
      end

      it 'should display the user\'s page after successfully updating' do
        expect(response).to redirect_to user
      end
    end
  end

  describe '#Destroy' do
    it 'raise RuntimeError if user is not logged in' do
      expect{ delete :destroy, params: { user_id: user, id: subject }}.to raise_error RuntimeError
    end

    it 'decrease questions count by 1 after deleting the question' do
      temp = subject
      new_user = user
      login
      expect{ delete :destroy, params: { user_id: new_user, id: temp }}.to change(Question, :count).by(-1)
    end

    it 'should redirect to user\'s page after deleting' do
      login
      redirect_to user
      expect(response).to have_http_status(:ok)
    end
  end
end