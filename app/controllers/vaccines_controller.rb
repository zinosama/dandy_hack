class VaccinesController < ApplicationController
	before_action :logged_in_user

	def index
		@user = User.find(params[:user_id])
		@vaccine_records = @user.users_vaccines.order(year_injected: :desc, month_injected: :desc, date_injected: :desc)
		@record = UsersVaccine.new

		@months = UsersVaccine.months
		@years = UsersVaccine.years
		@days = UsersVaccine.days
	end

end
