class Track < ActiveRecord::Base
  belongs_to :artist

  def self.create_tracks(artist)
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
    soundcloud_tracks = client.get('/tracks', :q => "#{artist.name}", :licence => 'cc-by-sa')
    soundcloud_tracks.each do |track|
      Track.create(:source => "soundcloud", :name => track.title, :url => track.permalink_url, :image_url => track.artwork_url, :release_date => track.created_at, :artist_id => artist.id)
    end
    spotify_tracks = RSpotify::Artist.search(artist.name).first.top_tracks("US")
    spotify_tracks.each do |track|
      if track.album.release_date_precision == "year"
        Track.create(:source => "spotify", :name => track.name, :url => track.external_urls["spotify"], :image_url => track.album.images.first["url"], :release_date => Date.parse(track.album.release_date + "-01-01"), :artist_id => artist.id)
      elsif track.album.release_date_precision == "month"
        Track.create(:source => "spotify", :name => track.name, :url => track.external_urls["spotify"], :image_url => track.album.images.first["url"], :release_date => Date.parse(track.album.release_date + "-01"), :artist_id => artist.id)
      else
        Track.create(:source => "spotify", :name => track.name, :url => track.external_urls["spotify"], :image_url => track.album.images.first["url"], :release_date => Date.parse(track.album.release_date), :artist_id => artist.id)
      end
    end
  end
end