class Artist < ActiveRecord::Base
  has_many :artist_users
  has_many :artist_genres
  has_many :users, through: :artist_users
  has_many :genres, through: :artist_genres

  def create_slug
    self.update(:slug => self.name.downcase.gsub(/[^a-z1-9$]+/, '-').chomp('-'))
  end

  def self.create_artist_from_spotify(name, image_url, profile_url)
    artist = Artist.new(:name => name, :image_url => image_url, :profile_url => profile_url)
    artist.create_slug
    artist.save
    return artist
  end
end