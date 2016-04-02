class User < ActiveRecord::Base
	attr_accessor :remember_token
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	has_secure_password

	before_save :downcase_email

	validates :first_name, presence: true, null: false, length: { maximum: 50 }
	validates :last_name, presence: true, null: false, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true #allows nil so that user can update without password. nil is checked in has_secure_password.

	def self.new_token
		SecureRandom.urlsafe_base64
	end

	def self.digest(input_string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(input_string, cost: cost)
	end

	def remember 
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	def forget
		update_attribute(:remember_digest, nil)
	end

	def authenticated?(attribute, token)
		digest = self.send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	private 

	def downcase_email
		self.email.downcase!
	end
end
