class AddGoogleAuthColumnsToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :access_token, :string
    add_column :users, :refresh_access_token, :string
    add_column :users, :access_token_expires_at, :datetime
  end
end
