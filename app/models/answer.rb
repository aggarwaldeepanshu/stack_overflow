class Answer < ApplicationRecord
  belongs_to :question

  has_one :answer_vote, dependent: :destroy
end
