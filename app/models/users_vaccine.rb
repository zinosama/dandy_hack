class UsersVaccine < ActiveRecord::Base
	belongs_to :user
	belongs_to :vaccine

	validates :user, presence: true
	validates :vaccine, presence: true
	validates :date_injected, presence: true
end
