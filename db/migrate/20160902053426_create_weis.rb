class CreateWeis < ActiveRecord::Migration
  def change
    create_table :weis do |t|
      t.string :name
      t.boolean :enabled
      t.decimal :price
      t.integer :seats
      t.date :date

      t.timestamps
    end
  end
end
