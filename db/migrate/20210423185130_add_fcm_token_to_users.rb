class AddFcmTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :fcm_token, :string
    add_column :users, :profile_url, :string
  end
end
