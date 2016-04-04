require 'test_helper'

class VaccinesControllerTest < ActionController::TestCase

	def setup
		@user = users(:one)
	end

	test 'should redirect index if not logged in' do
		get :index, user_id: @user.id
		assert_redirected_to login_url
		assert_not flash.empty?
	end

	test 'should get index' do
		log_in_as @user
		get :index, user_id: @user.id
		assert_response :success
		assert_template 'vaccines/index'
	end
end
