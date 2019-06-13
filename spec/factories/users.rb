FactoryBot.define do
  factory :user do
    name { 'manu' }
    #u.sequence(:email) { |n| "john#{n}@gmail.com"}
    email { 'manu@gmail.com' }
    password { '12345' }
    password_confirmation { '12345' }
  end
end
