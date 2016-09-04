class CreateAzureRoles < ActiveRecord::Migration
  def change
    create_table :azure_roles do |t|
      t.string :azure_gid
      t.string :name
      t.text :roles

      t.timestamps
    end
  end
end
