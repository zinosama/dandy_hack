require 'test_helper'

class IllnessesUsersControllerTest < ActionController::TestCase

	def setup
		@user = users(:one)
	end

	test 'should redirect create if not logged in' do
		post :create, user_id: @user.id, illnesses_user: { date_contracted: DateTime.now - 1.day, date_recovered: DateTime.now, medicine: { name: "" }, illness: { name: "zika" } }
		assert_redirected_to login_url
		assert_not flash[:error].empty?
	end	

	test 'should get index' do
		get :index
		assert_response :success
		assert_template 'illnesses_users/index'
	end

end
