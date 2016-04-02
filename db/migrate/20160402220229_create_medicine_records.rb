class CreateMedicineRecords < ActiveRecord::Migration
  def change
    create_table :medicine_records do |t|
    	t.references :illnesses_user, index: true, null: false
    	t.references :medicine, index: true, null: false
      t.timestamps null: false
    end
  end
end
