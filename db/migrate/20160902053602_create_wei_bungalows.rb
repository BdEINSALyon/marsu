class CreateWeiBungalows < ActiveRecord::Migration
  def change
    create_table :wei_bungalows do |t|
      t.integer :wei_id
      t.string :name
      t.integer :seats
      t.integer :wei_bus_id
      t.string :gender

      t.timestamps
    end
  end
end
