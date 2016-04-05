class Illness < ActiveRecord::Base
	has_many :illnesses_users
	has_many :users, through: :illnesses_users

	validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
end
