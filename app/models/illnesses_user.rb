class IllnessesUser < ActiveRecord::Base
	belongs_to :illness
	belongs_to :user

	has_many :medicine_records
	has_many :medicines, through: :medicine_records

	validates :date_contracted, presence: true
	validates :date_recovered, presence: true

	def display_contracted_date
		self.date_contracted.strftime("%B %e, %Y")
	end

	def display_recovered_date
		self.date_recovered.strftime("%B %e, %Y")
	end

	def translate_time
		self.date_contracted = DateTime.parse(self.date_contracted) if self.date_contracted  
		self.date_recovered = DateTime.parse(self.date_recovered) if self.date_recovered
	end
end
