require 'test_helper'

class VaccinesControllerTest < ActionController::TestCase

	def setup
		@user = users(:one)
	end

	test 'should get index' do
		get :index, user_id: @user.id
		assert_response :success
		assert_template 'vaccines/index'
	end
end
