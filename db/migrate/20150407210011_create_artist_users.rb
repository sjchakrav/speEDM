class CreateArtistUsers < ActiveRecord::Migration
  def change
    create_table :artist_users do |t|
      t.references :user
      t.references :artist
    end
    add_foreign_key :artist_users, :artists
    add_foreign_key :artist_users, :users
  end
end
