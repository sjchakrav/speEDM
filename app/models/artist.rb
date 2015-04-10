class Artist < ActiveRecord::Base
  has_many :artist_users
  has_many :artist_genres
  has_many :users, through: :artist_users
  has_many :genres, through: :artist_genres
  has_many :tracks
  before_save :create_slug

  def self.create_artist_from_spotify(name, image_url, profile_url)
    Artist.create(:name => name, :image_url => image_url, :profile_url => profile_url)
  end

  private

  def create_slug
    self.slug = self.name.downcase.gsub(/[^a-z1-9$]+/, '-').chomp('-')
  end
end