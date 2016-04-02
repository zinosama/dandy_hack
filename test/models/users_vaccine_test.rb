require 'test_helper'

class UsersVaccineTest < ActiveSupport::TestCase

	def setup
		user = users(:one)
		vaccine = vaccines(:one)
		@users_vaccine = UsersVaccine.new( user: user, vaccine: vaccine, date_injected: DateTime.now )
	end

	test 'should be valid' do
		assert @users_vaccine.valid?
	end

	test 'should have a user' do
		@users_vaccine.user = nil
		assert_not @users_vaccine.valid?
	end

	test 'should have a vaccine' do
		@users_vaccine.vaccine = nil
		assert_not @users_vaccine.valid?
	end

	test 'should have a date injected' do
		@users_vaccine.date_injected = ""
		assert_not @users_vaccine.valid?
	end
end
