FactoryBot.define do
  factory :question do
  	#@user = build(:user)
  	#@user.questions.build({ "title" => "my title", "body" => "body of question" })
    title { 'my title' }
    body { 'body of question' }
  end
end
