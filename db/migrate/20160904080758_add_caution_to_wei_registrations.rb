class AddCautionToWeiRegistrations < ActiveRecord::Migration
  def change
    add_column :wei_registrations, :caution, :boolean
    add_column :wei_registrations, :details, :text
    add_column :wei_registrations, :medical_details, :text
  end
end
