class CreateWeiBuses < ActiveRecord::Migration
  def change
    create_table :wei_buses do |t|
      t.integer :wei_id
      t.string :name
      t.integer :seats

      t.timestamps
    end
  end
end
