class CreateApplicationTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :application_tokens do |t|
      t.integer :application_id
      t.string :token
      t.datetime :expiration

      t.timestamps
    end
  end
end
