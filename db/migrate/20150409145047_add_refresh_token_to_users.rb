class AddRefreshTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_expires_at, :integer
  end
end
