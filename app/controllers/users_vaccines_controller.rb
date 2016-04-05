class UsersVaccinesController < ApplicationController
	before_action :logged_in_user
	before_action :correct_user, only: [:create]
	before_action :correct_owner, only: [:edit, :update, :destroy]

	def create
		user = User.find(params[:user_id])
		vaccine = Vaccine.find_or_create_by(name: params[:users_vaccine][:vaccine][:name])
		unless vaccine
			redirect_and_flash( user_vaccines_url(user), :error, "Error: Missing vaccine information" )
			return
		end
		record = user.users_vaccines.build(users_vaccine_params)
		record.vaccine = vaccine
		record.save ? redirect_and_flash( user_vaccines_url(user), :success, "New Record Added" ) : redirect_and_flash( user_vaccines_url(user), :error, "Error: Missing vaccine information" )
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

	def destroy
		record = UsersVaccine.find(params[:id])
		record.destroy
		redirect_and_flash(user_vaccines_url(record.user), :success, "Vaccine Record Deleted")
	end

	private 

	def correct_owner
		record = UsersVaccine.find_by(id: params[:id])
		user = record.user
		redirect_and_flash( root_url, :error, "Access denied" ) unless current_user == user
	end

	def users_vaccine_params
		params.require(:users_vaccine).permit(:date_injected, :month_injected, :year_injected)
	end

	def update_record(record)
		if record.update_attributes(users_vaccine_params)
			redirect_and_flash(user_vaccines_url(record.user), :success, "Vaccine Record Updated")
		else
			redirect_and_flash(edit_users_vaccine_url(record.user), :error, "Please specify time of administration")
			return
		end
	end

end
