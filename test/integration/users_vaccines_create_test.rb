require 'test_helper'

class UsersVaccinesCreateTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:one)
	end

	test 'valid users vaccine - new users_vaccine' do
		log_in_as @user
		get user_vaccines_url(@user)
		assert_template 'vaccines/index'

		assert_difference 'UsersVaccine.count', 1 do
			post user_users_vaccines_url(@user), users_vaccine: { date_injected: 1, month_injected: 1, year_injected: 2011, vaccine: { name: "new vaccine" } }
		end

		assert_redirected_to user_vaccines_url(@user)
		assert_not flash.empty?
		follow_redirect!

		assert_select 'a', text: 'new vaccine', count: 1
		assert_select 'div.description', text: 'This vaccine was administered on 1/1/2011.', count: 1
	end

	test 'valid users vaccine - new vaccine' do
		log_in_as @user
		assert_difference 'Vaccine.count', 1 do
			post user_users_vaccines_url(@user), users_vaccine: { date_injected: 1, month_injected: 1, year_injected: 2011, vaccine: { name: "neeew vaccine" } }
		end
	end

	test 'invalid users vaccine' do
		log_in_as @user
		assert_no_difference 'UsersVaccine.count' do
			post user_users_vaccines_url(@user), users_vaccine: { date_injected: "", month_injected: "", year_injected: "", vaccine: { name: "" } }
		end
		assert_redirected_to user_vaccines_url(@user)
		assert_not flash.empty?
	end

end
