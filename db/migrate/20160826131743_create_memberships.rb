class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.string :name
      t.decimal :price
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
