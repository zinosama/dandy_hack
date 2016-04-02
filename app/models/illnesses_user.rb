class IllnessesUser < ActiveRecord::Base
	belongs_to :illness
	belongs_to :user

	has_many :medicine_records
	has_many :medicines, through: :medicine_records

	validates :date_contracted, presence: true
	validates :date_recovered, presence: true
end
