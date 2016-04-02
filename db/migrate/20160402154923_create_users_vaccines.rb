class CreateUsersVaccines < ActiveRecord::Migration
  def change
    create_table :users_vaccines do |t|
    	t.references :user, null: false, index: true
    	t.references :vaccine, null: false, index: true

    	t.integer :date_injected, null: false
    	t.integer :month_injected, null: false
    	t.integer :year_injected, null: false
    	
      t.timestamps null: false
    end
  end
end
