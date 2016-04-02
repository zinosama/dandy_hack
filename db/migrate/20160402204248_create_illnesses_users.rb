class CreateIllnessesUsers < ActiveRecord::Migration
  def change
    create_table :illnesses_users do |t|
    	t.references :illness, index: true
    	t.references :user, index: true

    	t.datetime :date_contracted
    	t.datetime :date_recovered
    	t.string :symptoms

      t.timestamps null: false
    end
  end
end
