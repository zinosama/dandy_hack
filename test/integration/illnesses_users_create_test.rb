require 'test_helper'

class IllnessesUsersCreateTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:one)
	end

	test 'valid new illness with no medicine' do
		log_in_as @user
		get user_illnesses_url(@user)
		assert_template 'illnesses/index'

		assert_select 'div.header', text: "cancer", count: 0

		assert_difference 'Illness.count', 1 do
			post user_illnesses_users_url(@user), illnesses_user: { illness: { name: "cancer" }, date_contracted: "1/1/2011", date_recovered: "2/2/2012", medicine: { name: "" } }
		end
		assert_redirected_to user_illnesses_url(@user)
		assert_not flash[:success].empty?
		follow_redirect!

		assert_select 'div.header', text: "cancer", count: 1
	end

	test 'valid previous illness with no mdeicine' do
		@user.illnesses_users.create(illness: illnesses(:one), date_contracted: "1/1/2011", date_recovered: "2/2/2012")
		
		log_in_as @user
		get user_illnesses_url(@user)
		assert_select 'div.header', text: "cold", count: 1

		assert_no_difference 'Illness.count' do
			post user_illnesses_users_url(@user), illnesses_user: { illness: { name: "cold" }, date_contracted: "3/3/2012", date_recovered: "4/4/2012", medicine: { name: "" } }
		end
		assert_redirected_to user_illnesses_url(@user)
		assert_not flash[:success].empty?
		follow_redirect!

		assert_select 'div.header', text: "cold", count: 2
	end	

	test 'valid new illness with medicines' do
		log_in_as @user
		get user_illnesses_url(@user)

		assert_select 'div.header', text: "cancer", count: 0
		assert_select 'div.header', text: "cancer med A", count: 0
		assert_select 'div.header', text: "cancer med B", count: 0

		assert_difference 'Medicine.count', 2 do
			post user_illnesses_users_url(@user), illnesses_user: { illness: { name: "cancer" }, date_contracted: "1/1/2011", date_recovered: "2/2/2012", medicine: { name: ["cancer med A", "cancer med B"] } }
		end

		assert_redirected_to user_illnesses_url(@user)
		assert_not flash[:success].empty?
		follow_redirect!

		assert_select 'div.header', text: "cancer", count: 1
		assert_select 'div.header', text: "cancer med A", count: 1
		assert_select 'div.header', text: "cancer med B", count: 1


	end
end
