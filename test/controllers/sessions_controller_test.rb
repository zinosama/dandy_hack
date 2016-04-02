require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

	test 'should get new' do
		get :new
		assert_response :success
		assert_template 'sessions/new'
	end
end
