class User < ActiveRecord::Base
	attr_accessor :remember_token, :BLOOD_TYPES
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	has_secure_password

	before_save :downcase_email

	has_many :users_vaccines
	has_many :vaccines, through: :users_vaccines
	has_many :illnesses_users
	has_many :illnesses, through: :illnesses_users

	validates :first_name, presence: true, null: false, length: { maximum: 50 }
	validates :last_name, presence: true, null: false, length: { maximum: 50 }
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true #allows nil so that user can update without password. nil is checked in has_secure_password.
	validates :weight, numericality: true, allow_nil: true
	validates :height, numericality: true, allow_nil: true
	validates :age, numericality: true, allow_nil: true
	validates :gender, numericality: true, allow_nil: true
	validates :blood_type, numericality: true, allow_nil: true 

	def self.blood_types
		[["A-", 0], ["A+", 1], ["B-", 2], ["B+", 3], ["AB-", 4], ["AB+", 5], ["O-", 6], ["O+", 7]]
	end

	def bmi
		(self.weight / (self.height * self.height) * 703).round(2) if (self.weight && self.height)
	end

	def display_blood_type
		User.blood_types[self.blood_type][0] if self.blood_type
	end

	def he_or_she
		return "This person" unless self.gender
		self.gender == 0 ? "he" : "she"
	end

	def full_name
		"#{self.first_name.capitalize} #{self.last_name.capitalize}"
	end

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
