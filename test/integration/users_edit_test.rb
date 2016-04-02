require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

	def setup
		@user = users(:one)
	end

	test 'valid update - personal' do
		get user_url(@user)
		assert_template 'users/show'

		patch user_url(@user), form_type: "personal", user: { height: 1, weight: 2, blood_type: 3, gender: 0, age: 4 }
		assert_redirected_to user_url(@user)
		assert_not flash.empty?

		assert_equal 1, @user.reload.height
		assert_equal 2, @user.reload.weight
		assert_equal 3, @user.reload.blood_type
		assert_equal 0, @user.reload.gender
		assert_equal 4, @user.reload.age
	end

	test 'valid update - account' do
		get edit_user_url(@user)
		assert_template 'users/edit'

		patch user_url(@user), form_type: "account", user: { email: "testttt@gmail.com", first_name: "yo", last_name: "hey", password: "dddaaa", passwowrd_confirmation: "dddaaa" }
		assert_redirected_to user_url(@user)
		assert_not flash.empty?

		assert_equal "testttt@gmail.com", @user.reload.email
		assert_equal "yo", @user.reload.first_name
		assert_equal "hey", @user.reload.last_name
	end
end
