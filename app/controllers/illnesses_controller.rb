class IllnessesController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@records = @user.illnesses_users
		@record = IllnessesUser.new
	end
end
