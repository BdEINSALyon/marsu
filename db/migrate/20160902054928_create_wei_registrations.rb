class CreateWeiRegistrations < ActiveRecord::Migration
  def change
    create_table :wei_registrations do |t|
      t.integer :student_id
      t.integer :wei_id
      t.integer :wei_bungalow_id
      t.integer :wei_bus_id
      t.string :status
      t.boolean :paid

      t.timestamps
    end
  end
end
