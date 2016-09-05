class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :code
      t.integer :student_id

      t.timestamps
    end
  end
end
