class VaccinesController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@vaccine_records = @user.users_vaccines.order(year_injected: :desc, month_injected: :desc, date_injected: :desc)
		@vaccine = Vaccine.new

		@months = UsersVaccine.months
		@years = UsersVaccine.years
		@days = UsersVaccine.days
	end

	def create
		vaccine = Vaccine.find_or_create_by(name: params[:vaccine][:name])
		user = User.find(params[:user_id])
		user.users_vaccines.create(vaccine: vaccine, date_injected: params[:vaccine][:users_vaccine][:date_injected], month_injected: params[:vaccine][:users_vaccine][:month_injected], year_injected: params[:vaccine][:users_vaccine][:year_injected])
		flash[:success] = "New Record Added"
		redirect_to user_vaccines_url(user)
	end

	private 

	def vaccine_params
		params.require(:vaccine).permit(:name)
	end	
end
