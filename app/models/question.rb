class Question < ApplicationRecord
	belongs_to :user

	has_many :answers, dependent: :destroy

	has_one :question_vote, dependent: :destroy
end
