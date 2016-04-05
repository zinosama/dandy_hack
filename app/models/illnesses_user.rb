class IllnessesUser < ActiveRecord::Base
	belongs_to :illness
	belongs_to :user

	has_many :medicine_records
	has_many :medicines, through: :medicine_records

	validates :date_contracted, presence: true
	validates :date_recovered, presence: true
	validates :user, presence: true
	validates :illness, presence: true
	validates :symptoms, allow_nil: true, length: { maximum: 255 }

	validate :cannot_recover_before_contracted

	def display_contracted_date
		self.date_contracted.strftime("%B %e, %Y")
	end

	def display_recovered_date
		self.date_recovered.strftime("%B %e, %Y")
	end

	private 

	def cannot_recover_before_contracted
		begin
			result = date_recovered > date_contracted
		rescue
			errors.add(:date_recovered, "can't be before contracted date")
		else
			errors.add(:date_recovered, "can't be before contracted date") unless result	
		end
	end



end
