class Artist < ActiveRecord::Base
  has_many :artist_users
  has_many :artist_genres
  has_many :users, through: :artist_users
  has_many :genres, through: :artist_genres

  def self.create_artist_from_spotify(name, image_url, profile_url)
    Artist.create(:name => name, :image_url => image_url, :profile_url => profile_url)
  end
end