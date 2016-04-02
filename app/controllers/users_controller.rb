class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			log_in @user
			flash[:success] = "Thank you for registering!"
			redirect_to user_url(@user)
		else
			render 'new'
		end
	end

	def show
		@user = User.find(params[:id])
		@blood_types = User.blood_types
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes( params[:form_type] == 'personal' ? user_personal_params : user_params )
			flash[:success] = "Updated successfully"
			redirect_to user_url(@user)
		else
			render 'show'
		end
	end

	private

	def user_personal_params
		params.require(:user).permit(:weight, :height, :blood_type, :age, :gender)
	end

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end
end
