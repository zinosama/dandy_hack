class Vaccine < ActiveRecord::Base
	validates :name, null: false, length: { maximum: 100 }, uniqueness: { case_sensitive: false }
end
