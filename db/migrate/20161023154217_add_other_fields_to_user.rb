class AddOtherFieldsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :confirm_token, :string
  	add_column :users, :confirm_at, :datetime
  	add_column :users, :auth_meta_data, :text
  	rename_column :users, :password_hash, :password_digest
  	add_index :users, :username, unique: true
  end
end
