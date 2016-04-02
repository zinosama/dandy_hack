class Medicine < ActiveRecord::Base
	has_many :medicine_records
	has_many :illnesses_users, through: :medicine_records
end
