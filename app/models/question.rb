class Question < ApplicationRecord

	validates :title, presence: true,
					  length: { maximum: 100 }
	validates :body, presence: true,
					 length: { maximum: 500 }

	belongs_to :user
	has_many :answers, dependent: :destroy
	has_one :question_vote, dependent: :destroy
end
