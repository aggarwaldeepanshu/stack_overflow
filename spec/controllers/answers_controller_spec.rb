RSpec.describe AnswersController, type: :controller do
  let(:user) do
   create(:user)
  end

  let(:ques) do
    create(:question, user: user, title: 'question title', body: 'question body')
  end

  subject do
    create(:answer, user: user, question: ques, body: 'anwer content')
  end

  let(:login) do
    #new_user = user
    sign_in user
  end

  let(:update_params) do
    { :body => 'new content' }
  end

  let(:empty_content) do
    { body: ''}
  end

  let(:overflow) do
    { body: 'a'*701}
  end

  describe '#Create' do 
    context 'after creating an answer' do
      it 'check if count increments by 1' do
        login
        expect{ subject }.to change(Answer, :count).by(1)
      end
      
      it 'should redirect to question page' do
        login
        redirect_to ques
        expect(response).to have_http_status(:ok)
      end
    end

    context 'raise error when' do
      it 'content is empty' do
        expect{ post :create, params: { question_id: ques, answer: empty_content } }.to raise_error RuntimeError
      end

      it 'length of content exceeds maximum size' do
        expect{ post :create, params: { question_id: ques, answer: overflow } }.to raise_error RuntimeError
      end
    end
  end

  describe '#Edit' do
    it 'successfully redirects to edit page' do
      login
      get :edit, params: {question_id: ques, id: subject }
      expect(response).to have_http_status(:success)
    end

    context 'raise error when' do
      it 'user is not logged in' do
        expect{ get :edit, params: {question_id: ques, id: subject } }.to raise_error RuntimeError
      end
    end
  end

  describe '#Update' do
    context 'On performing update action' do
      before(:each) do
        login
        put :update, params: { :question_id => ques, :id => subject, :answer => update_params }
        subject.reload
      end
      it 'check if content updated successfully' do
        expect(subject.body).to eq(update_params[:body])
      end

      it 'should successfully redirects to question\'s show page' do
        expect(response).to redirect_to ques
      end
    end

    context 'Do not update content if' do
      it 'user is not logged in' do
        expect{ put :update, params: { :question_id => ques, :id => subject, :answer => update_params } }.to raise_error RuntimeError
      end
      it 'it is empty' do
        expect{ put :update, params: { question_id: ques, id: subject, answer: empty_content } }.to raise_error RuntimeError
      end

      it 'it\'s size exceeds maximum length' do
        expect{ put :update, params: { question_id: ques, id: subject, answer: overflow } }.to raise_error RuntimeError
      end
    end
  end

  describe '#Destroy' do
    it 'do not delete if user is not logged in' do
      expect{ delete :destroy, params: { :question_id => ques, :id => subject} }.to raise_error RuntimeError
    end
    context 'after deleting an answer' do
      it 'count decreases by 1' do
        login
        temp = subject
        expect{ delete :destroy, params: { :question_id => ques, :id => temp } }.to change(Answer, :count).by(-1)
      end

      it 'it should redirect to user\'s show page' do
        redirect_to ques
        expect(response).to have_http_status(:ok)
      end
    end
  end
end