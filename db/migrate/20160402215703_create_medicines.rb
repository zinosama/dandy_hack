class CreateMedicines < ActiveRecord::Migration
  def change
    create_table :medicines do |t|
    	t.string :name, null: false, unique: true, index: true 
      t.timestamps null: false
    end
  end
end
