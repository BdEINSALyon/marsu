class CreateLogEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :log_entries do |t|
      t.integer :user_id
      t.string :path
      t.text :params
      t.string :ip
      t.string :method
      t.string :controller
      t.string :action
      t.integer :status

      t.timestamps
    end
  end
end
