class ChangeProvidersColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :provider, :email
    remove_column :users, :uid, :string
  end
end
