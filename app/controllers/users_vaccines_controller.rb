class UsersVaccinesController < ApplicationController
	
	def create
		user = User.find(params[:user_id])
		vaccine = Vaccine.find_or_create_by(name: params[:users_vaccine][:vaccine][:name])
		unless vaccine
			flash[:error] = "Please provide the vaccine name and administraton time"
			redirect_to user_vaccines_url(user)
			return
		end
		record = user.users_vaccines.build(users_vaccine_params)
		record.vaccine = vaccine
		if record.save
			flash[:success] = "New Record Added"
			redirect_to user_vaccines_url(user)
		else
			flash[:error] = "Please provide the vaccine name and administraton time"
			redirect_to user_vaccines_url(user)
		end
	end

	def edit
		@days = UsersVaccine.days
		@months = UsersVaccine.months
		@years= UsersVaccine.years

		@record = UsersVaccine.find(params[:id])
		@user = @record.user
	end

	def update
		record = UsersVaccine.find(params[:id])
		if params[:users_vaccine][:vaccine][:name].empty?
			update_record(record)
		else #vaccine name has been changed
			if record.vaccine.users.size == 1
				record.vaccine.update_attributes(name: params[:users_vaccine][:vaccine][:name])
				update_record(record)
			else
				vaccine = Vaccine.find_or_create_by(name: params[:users_vaccine][:vaccine][:name])
				record.vaccine = vaccine
				update_record(record)
			end
		end
	end

	private 

	def users_vaccine_params
		params.require(:users_vaccine).permit(:date_injected, :month_injected, :year_injected)
	end

	def update_record(record)
		if record.update_attributes(users_vaccine_params)
			redirect_and_flash(user_vaccines_url(record.user), :success, "Vaccine Record Updated")
		else
			redirect_and_flash(user_vaccines_url(record.user), :error, "Please specify time of administration")
			return
		end
	end

end
