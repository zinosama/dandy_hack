require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	
	def setup
		ActionMailer::Base.deliveries.clear
	end

	test 'invalid signup information' do
		get signup_path
		assert_no_difference 'User.count' do 
			post users_path, user: { first_name: "", last_name: "", email: "invalidemail", password: "1111", password_confirmation: "111" }
		end
		assert_template 'users/new'
		assert_select 'li', count: 5
		assert_select 'div.ui.error.message', count: 1
	end

	test 'valid signup information with account activation' do
		get signup_path
		assert_difference 'User.count', 1 do 
			post users_path, user: { first_name: "Jiyong", last_name: "Kwon", email: "gd@gmail.com", password: "dasdaa", password_confirmation: "dasdaa"}
		end
		user = assigns(:user)
		assert_redirected_to user_url(user)
		assert_not flash.empty?
		assert is_logged_in?
	end	

end
