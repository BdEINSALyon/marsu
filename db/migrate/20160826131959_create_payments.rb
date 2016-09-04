class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :payable_type
      t.integer :payable_id
      t.integer :payment_method_id
      t.boolean :refunded
      t.integer :student_id
      t.integer :user_id
      t.text :details

      t.timestamps
    end
  end
end
