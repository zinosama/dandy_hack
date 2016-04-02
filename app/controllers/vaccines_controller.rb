class VaccinesController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@vaccine_records = @user.users_vaccines.order(year_injected: :desc, month_injected: :desc, date_injected: :desc)
		@vaccine = Vaccine.new
		@record = UsersVaccine.new

		@months = UsersVaccine.months
		@years = UsersVaccine.years
		@days = UsersVaccine.days
	end

	def create
		user = User.find(params[:user_id])
		@vaccine = Vaccine.find_or_create_by(name: params[:vaccine][:name])
		unless @vaccine
			flash[:error] = "Please provide the vaccine name and administraton time"
			redirect_to user_vaccines_url(user)
			return
		end
		record = user.users_vaccines.build(vaccine: @vaccine, date_injected: params[:vaccine][:users_vaccine][:date_injected], month_injected: params[:vaccine][:users_vaccine][:month_injected], year_injected: params[:vaccine][:users_vaccine][:year_injected])
		if record.save
			flash[:success] = "New Record Added"
			redirect_to user_vaccines_url(user)
		else
			flash[:error] = "Please provide the vaccine name and administraton time"
			redirect_to user_vaccines_url(user)
		end
	end

	private 

	def vaccine_params
		params.require(:vaccine).permit(:name)
	end	
end
