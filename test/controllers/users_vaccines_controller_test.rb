require 'test_helper'

class UsersVaccinesControllerTest < ActionController::TestCase

	def setup
		@user = users(:one)
		@record = users_vaccines(:one)
	end 

	test 'should redirect create when not logged in' do
		post :create, user_id: @user.id, users_vaccine: { date_injected: 1, month_injected: 1, year_injected: 2011 }
		assert_redirected_to login_url
		assert_not flash[:error].empty?
	end

	test 'should redirect edit when not logged in' do
		get :edit, id: @record.id
		assert_redirected_to login_url
		assert_not flash[:error].empty?
	end

	test 'should redirect edit when not the owner' do
		log_in_as @user
		get :edit, id: @record.id
		assert_redirected_to root_url
		assert_not flash[:error].empty?
	end

	test 'should redirect update when not logged in' do
		patch :update, id: @record.id, users_vaccine: { date_injected: 2, month_injected: 2, year_injected: 2012 }
		assert_redirected_to login_url
		assert_not flash[:error].empty?
	end

	test 'should redirect update when not the owner' do
		log_in_as @user
		patch :update, id: @record.id, users_vaccine: { date_injected: 2, month_injected: 2, year_injected: 2012 }
		assert_redirected_to root_url
		assert_not flash[:error].empty?
	end

	test 'should redirect destroy when not logged in' do
		delete :destroy, id: @record.id
		assert_redirected_to login_url
		assert_not flash[:error].empty?
	end

	test 'should redirect destroy when not the right user' do
		log_in_as @user
		delete :destroy, id: @record.id
		assert_redirected_to root_url
		assert_not flash[:error].empty?
	end
end
