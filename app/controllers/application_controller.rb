class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

	def redirect_and_flash(target_url, flash_symbol, flash_message)
		redirect_to target_url
		flash[flash_symbol] = flash_message
	end
end
