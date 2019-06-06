FactoryBot.define do
  factory :question_vote do
    upvote { 1 }
    downvote { 1 }
    question { nil }
  end
end
