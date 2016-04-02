class CreateMedicineRecords < ActiveRecord::Migration
  def change
    create_table :medicine_records do |t|

      t.timestamps null: false
    end
  end
end
