class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :first_name, null: false
    	t.string :last_name, null: false
    	t.string :email, null: false, unique: true, index: true
    	t.string :password_digest, null: false
    	t.string :remember_digest
    	
      t.decimal :weight
      t.decimal :height
      t.integer :blood_type
      t.integer :gender
      t.integer :age 
      
      t.timestamps null: false
    end
  end
end
