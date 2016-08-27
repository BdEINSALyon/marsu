class AddAzureTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :azure_token, :string
  end
end
