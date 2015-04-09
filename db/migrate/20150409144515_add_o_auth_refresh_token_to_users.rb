class AddOAuthRefreshTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_refresh_token, :string
  end
end
