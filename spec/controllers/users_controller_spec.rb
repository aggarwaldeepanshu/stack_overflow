RSpec.describe UsersController, type: :controller do
	let(:create_user) do
		create(:user)
	end

	let(:blank_name) do
		build(:user, :name => ' ')
	end

	# let(:user2) do
	# 	create(:user, :name => 'john', :email => 'john@gmail.com')
	# end

	describe '#Show' do
		before(:each) do
			get :show, params: { id: create_user }
		end
		it 'returns ok status' do
			expect(response).to have_http_status(:ok)
		end
	end

	describe '#New' do
		before(:each) { get :new }
		it 'returns ok status' do
			expect(response).to have_http_status(:ok)
		end
	end
end