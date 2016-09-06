class AddParentalToWeiRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :wei_registrations, :parental, :boolean
  end
end
