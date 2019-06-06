RSpec.describe StaticPagesController, type: :controller do
	it "should get help" do
		get :help
		expect(response).to_not have_http_status(:not_found)
	end
end