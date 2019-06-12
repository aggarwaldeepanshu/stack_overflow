RSpec.describe UsersController, type: :controller do
	subject do
		create(:user)
	end

	context '#Show' do
		before(:each) { get :show, params: { id: subject } }
		it 'returns ok status' do
			expect(response).to have_http_status(:ok)
		end
	end

	context '#New' do
		before(:each) { get :new }
		it 'returns ok status' do
			expect(response).to have_http_status(:ok)
		end
	end
end