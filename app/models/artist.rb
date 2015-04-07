class Artist < ActiveRecord::Base
  has_many :artist_users
  has_many :artist_genres
  has_many :users, through: :artist_users
  has_many :genres, through: :artist_genres
end
