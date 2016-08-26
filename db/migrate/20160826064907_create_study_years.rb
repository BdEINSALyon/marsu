class CreateStudyYears < ActiveRecord::Migration[5.0]
  def change
    create_table :study_years do |t|
      t.string :name
      t.integer :year
      t.boolean :active

      t.timestamps
    end
  end
end
