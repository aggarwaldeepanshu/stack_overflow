require 'rails_helper'

RSpec.describe User, type: :model do
	before(:all) do
		@user1 = create(:user)
	end

	it 'is valid' do
		expect(@user1).to be_valid
	end

	it 'has unique email' do
		@user2 = build("email" => "manu@gmail.com")
		expect(@user2).to_not be_valid
	end
end
