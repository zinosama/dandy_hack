require 'test_helper'

class UsersVaccinesDestroyTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:one)
		@vaccine = vaccines(:two)
		@record = @user.users_vaccines.create(vaccine: @vaccine, date_injected: 1, month_injected: 1, year_injected: 2011)
	end

	test 'should destroy association' do
		log_in_as @user

		assert_difference 'UsersVaccine.count', -1 do
			delete users_vaccine_url(@record)
		end
		assert_redirected_to user_vaccines_url(@user)
		assert_not flash.empty?
	end

	test 'should destroy vaccine record if last association' do
		log_in_as @user

		assert_difference 'Vaccine.count', -1 do
			delete users_vaccine_url(@record)
		end
	end

	test 'should not destroy vaccine if not last association' do
		user2 = users(:two)
		user2.users_vaccines.create(vaccine: @vaccine, date_injected: 1, month_injected: 1, year_injected: 2011)
		
		log_in_as @user

		assert_no_difference 'Vaccine.count' do
			delete users_vaccine_url(@record)
		end
	end
end
