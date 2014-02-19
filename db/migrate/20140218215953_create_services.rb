class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.integer :phone
      t.string :email
      t.text :address
      t.string :no_customer
      t.string :program
      t.string :problem
      t.string :day_problem

      t.timestamps
    end
  end
end
