class MedicineRecord < ActiveRecord::Base
	belongs_to :medicine
	belongs_to :illnesses_user

end
