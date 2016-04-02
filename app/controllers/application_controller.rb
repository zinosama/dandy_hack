class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

	def redirect_and_flash(target_url, flash_symbol, flash_message)
		redirect_to target_url
		flash[flash_symbol] = flash_message
	end

	def logged_in_user
		unless logged_in?
			store_location
			flash[:error] = "Please log in first."
			redirect_to login_url
		end
	end

	def correct_user
		user = User.find_by(id: params[:user_id])
		unless current_user == user
			flash[:error] = "Access denied."
			redirect_to root_url
		end
	end
end
