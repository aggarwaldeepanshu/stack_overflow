FactoryBot.define do
  factory :question do
  	#@user = build(:user)
  	#@user.questions.build({ "title" => "my title", "body" => "body of question" })
    title { 'my title' }
    body { 'body of question' }
    #user1 = FactoryBot.create(:user).id
    #user1.questions.create({ :title => title, :body => body })
  end
end
