class IllnessesController < ApplicationController
	before_action :logged_in_user

	def index
		@user = User.find(params[:user_id])
		@records = @user.illnesses_users
		@record = IllnessesUser.new
	end
end