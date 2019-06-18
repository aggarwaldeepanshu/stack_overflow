class Answer < ApplicationRecord

  validates :body, presence: true,
				   length: { maximum: 700 }

  belongs_to :question
  belongs_to :user
  has_one :answer_vote, dependent: :destroy

  accepts_nested_attributes_for :answer_vote, allow_destroy: true
end
