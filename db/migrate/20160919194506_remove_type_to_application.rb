class RemoveTypeToApplication < ActiveRecord::Migration[5.0]
  def change
    remove_column :applications, :type
    add_column :applications, :app_type, :string
  end
end
