class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :gender
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :student_id
      t.integer :department_id
      t.integer :study_year_id
      t.string :phone
      t.date :birthday
      t.text :details

      t.timestamps
    end
  end
end
