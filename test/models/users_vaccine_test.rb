require 'test_helper'

class UsersVaccineTest < ActiveSupport::TestCase

	def setup
		user = users(:one)
		vaccine = vaccines(:one)
		@users_vaccine = UsersVaccine.new( user: user, vaccine: vaccine, date_injected: 20, month_injected: 10, year_injected: 2011 )
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

	test 'date injected should be number' do
		@users_vaccine.date_injected = ""
		assert_not @users_vaccine.valid?
		@users_vaccine.date_injected = "hi"
		assert_not @users_vaccine.valid?
	end

	test 'month injected should be number' do
		@users_vaccine.month_injected = ""
		assert_not @users_vaccine.valid?
		@users_vaccine.month_injected = "hi"
		assert_not @users_vaccine.valid?
	end

	test 'year injected should be number' do
		@users_vaccine.year_injected = ""
		assert_not @users_vaccine.valid?
		@users_vaccine.year_injected = "hi"
		assert_not @users_vaccine.valid?
	end
end
