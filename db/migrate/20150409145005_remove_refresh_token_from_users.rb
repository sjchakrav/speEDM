class RemoveRefreshTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :oauth_expires_at, :datetime
  end
end
