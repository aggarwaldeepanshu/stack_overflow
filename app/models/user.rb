class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	#has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	
	validates :name, presence: true,
					 length: { maximum: 50 }
	validates :email, presence: true, 
					  length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: {case_sensitive: false}
	# validates :password, presence: true,
	# 					 length: { minimum: 5 }
	validates :password_confirmation, presence: true

	has_many :questions, dependent: :destroy
	has_many :answers, dependent: :destroy

	accepts_nested_attributes_for :questions, :answers, allow_destroy: true
end
