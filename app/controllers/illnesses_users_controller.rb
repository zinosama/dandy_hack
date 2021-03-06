class IllnessesUsersController < ApplicationController
	before_action :logged_in_user, only: [:create]

	def create
		@user = User.find(params[:user_id])
		if illness_present?
			illness = Illness.find_or_create_by(name: params[:illnesses_user][:illness][:name])
			record = @user.illnesses_users.build(illnesses_user_params)
			record.illness = 	illness

			if record.save
				link_medicine(record) if medicine_present?
				redirect_and_flash(user_illnesses_url(@user), :success, "New Illness Recorded")
			else
				redirect_and_flash(user_illnesses_url(@user), :error, "Error. Please ensure dates are entered in the right format")
			end

		else
			redirect_and_flash(user_illnesses_url(@user), :error, "Error. Please enter a name for your illness")
		end
	end


	def index
		if params[:query]
			@illness = Illness.find_by(name: params[:query])
			@num_inffected = @illness.users.count
			@other_diseases = {}
			@other_vaccines = {}
			@illness.users.each do |user|
				user.vaccines.each do |vaccine|
					if @other_vaccines[vaccine.name]
						@other_vaccines[vaccine.name] += 1
					else
						@other_vaccines[vaccine.name] = 1
					end
				end

				user.illnesses.each do |illness|
					unless illness == @illness 
						if @other_diseases[illness.name]
							@other_diseases[illness.name] += 1
						else
							@other_diseases[illness.name] = 1
						end
					end
				end
			end
		end
	end

	def query
		if params[:illnesses_user][:illness][:name] && !params[:illnesses_user][:illness][:name].empty?
			redirect_to search_url(query: params[:illnesses_user][:illness][:name])
		else 
			redirect_and_flash(search_url, :error, "Empty search phrase")
		end
	end

	private 

	def illnesses_user_params
		params.require(:illnesses_user).permit(:date_contracted, :date_recovered, :symptoms)
	end

	def medicine_present?
		params[:illnesses_user][:medicine][:name].size != 1 && !params[:illnesses_user][:medicine][:name].empty?
	end

	def illness_present?
		params[:illnesses_user][:illness][:name] && !params[:illnesses_user][:illness][:name].empty?
	end

	def link_medicine(record)
		params[:illnesses_user][:medicine][:name].each do |name|
			unless name.empty?
				medicine = Medicine.find_or_create_by(name: name)
				MedicineRecord.find_or_create_by(illnesses_user: record, medicine: medicine)
			end
		end
	end
end
