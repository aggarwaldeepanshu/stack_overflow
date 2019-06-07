class Answer < ApplicationRecord

  validates :body, presence: true,
				   length: { maximum: 700 }

  belongs_to :question
  has_one :answer_vote, dependent: :destroy
end
