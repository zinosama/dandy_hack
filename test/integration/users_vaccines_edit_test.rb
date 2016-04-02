require 'test_helper'

class UsersVaccinesEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:one)
		@vaccine = vaccines(:one)
		@record = @user.users_vaccines.create(vaccine: @vaccine, date_injected: 1, month_injected: 1, year_injected: 2011)
	end

	test 'valid users_vaccine - users_vaccine update only' do
		assert_equal @record, @user.reload.users_vaccines.first
		log_in_as @user

		get edit_users_vaccine_url(@record)
		assert_template 'users_vaccines/edit'

		patch users_vaccine_url(@record), users_vaccine: { date_injected: 2, month_injected: 2, year_injected: 2012, vaccine: { name: "" }}
		assert_redirected_to user_vaccines_url(@user)
		assert_not flash.empty?

		assert_equal 2, @record.reload.date_injected
		assert_equal 2, @record.reload.month_injected
		assert_equal 2012, @record.reload.year_injected
		vaccine_name = @vaccine.name
		assert_equal vaccine_name, @vaccine.reload.name
	end

	test 'valid users_vaccine - combined update' do
		log_in_as @user
		patch users_vaccine_url(@record), users_vaccine: { date_injected: 3, month_injected: 3, year_injected: 2013, vaccine: { name: "hello" }}

		assert_equal 3, @record.reload.date_injected
		assert_equal 3, @record.reload.month_injected
		assert_equal 2013, @record.reload.year_injected
		vaccine_name = @vaccine.name
		assert_not_equal vaccine_name, @vaccine.reload.name
		assert_equal "hello", @vaccine.reload.name
	end

	test 'invalid users_vaccine' do
		log_in_as @user
		patch users_vaccine_url(@record), users_vaccine: { date_injected: "", month_injected: "", year_injected: "", vaccine: { name: "" }}
		assert_redirected_to edit_users_vaccine_url(@user)
		assert_not flash.empty?

		assert_equal @record, @record.reload
	end
end
