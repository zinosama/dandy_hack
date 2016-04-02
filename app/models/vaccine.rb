class Vaccine < ActiveRecord::Base
	has_many :users_vaccines
	has_many :users, through: :users_vaccines
	
	validates :name, presence: true, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
end
