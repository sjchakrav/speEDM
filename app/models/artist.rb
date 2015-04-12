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

  def spotify_tracks
    tracks.where(:source => "spotify").order(release_date: :desc)
  end

  def soundcloud_tracks
    tracks.where(:source => "soundcloud").order(release_date: :desc)
  end

  # Updates only if soundcloud has later release date than local db
  # Refactor Track class instead of repeatedly calling same code
  def self.update_tracks
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])

    Artist.all.each do |artist|
      soundcloud_tracks = client.get('/tracks', :q => "#{artist.name}", :licence => 'cc-by-sa')
      sc_latest_release_date = Date.parse(soundcloud_tracks.each_with_object([]) { |track, arr| arr << track.created_at }.sort.last)
      local_tracks = artist.tracks
      local_latest_release_date = local_tracks.max_by { |track| track.release_date }.release_date
      if sc_latest_release_date > local_latest_release_date
        artist.tracks.destroy_all
        Track.create_tracks(artist)
      end
    end
  end

  private

  def create_slug
    self.slug = self.name.downcase.gsub(/[^a-z1-9$]+/, '-').chomp('-')
  end
end