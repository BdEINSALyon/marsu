class AddAzureTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :azure_token, :string
  end
end
