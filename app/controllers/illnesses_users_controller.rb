class IllnessesUsersController < ApplicationController

	def create
		@user = User.find(params[:user_id])
		if illness_present?
			illness = Illness.find_or_create_by(name: params[:illnesses_user][:illness][:name])
			record = @user.illnesses_users.build(illnesses_user_params)
			record.illness = 	illness
			# record.translate_time
			if record.save
				if medicine_present?
					params[:illnesses_user][:medicine][:name].each do |name|
						unless name.empty?
							medicine = Medicine.find_or_create_by(name: name)
							MedicineRecord.find_or_create_by(illnesses_user: record, medicine: medicine)
						end
					end
				end
				redirect_and_flash(user_illnesses_url(@user), :success, "New Illness Recorded")
			else
				redirect_and_flash(user_illnesses_url(@user), :error, "Error. Please ensure dates are entered in the right format")
			end
		else
			redirect_and_flash(user_illnesses_url(@user), :error, "Error. Please enter a name for your illness")
		end
	end


	def index
		
	end

	private 

	def illnesses_user_params
		params.require(:illnesses_user).permit(:date_contracted, :date_recovered, :symptoms)
	end

	def medicine_present?
		params[:illnesses_user][:medicine][:name].size != 1
	end

	def illness_present?
		params[:illnesses_user][:illness][:name] && !params[:illnesses_user][:illness][:name].empty?
	end
end
