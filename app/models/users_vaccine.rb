class UsersVaccine < ActiveRecord::Base
	belongs_to :user
	belongs_to :vaccine

	validates :user, presence: true
	validates :vaccine, presence: true

	def inject_time
		"#{self.month_injected}/#{self.date_injected}/#{self.year_injected}"
	end

	def self.days
		(1..31).map{ |day| day }
	end

	def self.years
		(1950..2018).map{ |year| year }
	end

	def self.months
		(1..12).map{ |month| month }
	end
end
