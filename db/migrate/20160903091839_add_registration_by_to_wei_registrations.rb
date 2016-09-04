class AddRegistrationByToWeiRegistrations < ActiveRecord::Migration
  def change
    add_column :wei_registrations, :registration_by, :datetime
  end
end
