class User < ActiveRecord::Base
  has_many :artist_users
  has_many :artists, through: :artist_users

  def list_tracks(source)
    tracks_array = []
    artists.each do |artist|
      tracks_array << artist.tracks.where(:source => source)
    end
    tracks_array.flatten.sort_by { |track|  track.release_date }.reverse
  end

  # def spotify_tracks
  #   spotify_hash = {}
  #   i = 1
  #   artists.each do |artist|
  #     tracks = RSpotify::Artist.search(artist.name).first.top_tracks("US")
  #     tracks.each do |track|
  #       spotify_hash[i.to_s] ||= {}
  #       spotify_hash[i.to_s]["provider"] = "spotify"
  #       spotify_hash[i.to_s]["artist_name"] = artist.name
  #       spotify_hash[i.to_s]["track_name"] = track.name
  #       spotify_hash[i.to_s]["album_name"] = track.album.name
  #       spotify_hash[i.to_s]["image_url"] = track.album.images.first["url"]
  #       spotify_hash[i.to_s]["url"] = track.external_urls["spotify"]
  #       if track.album.release_date_precision == "year"
  #         spotify_hash[i.to_s]["release_date"] = Date.parse(track.album.release_date + "-01-01")
  #       elsif track.album.release_date_precision == "month"
  #         spotify_hash[i.to_s]["release_date"] = Date.parse(track.album.release_date + "-01")
  #       else
  #         spotify_hash[i.to_s]["release_date"] = Date.parse(track.album.release_date)
  #       end
  #       i += 1
  #     end
  #   end
  #   spotify_hash
  # end

  # def recent_spotify_tracks
  #   spotify_tracks.sort_by { |number, track| track["release_date"] }.reverse
  # end

  # def soundcloud_tracks
  #   soundcloud_hash = {}
  #   i = 1
  #   artists.each do |artist|
  #     client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
  #     tracks = client.get('/tracks', :q => "#{artist.name}", :licence => 'cc-by-sa')
  #     tracks.each.with_index(1) do |track, i|
  #       soundcloud_hash[i.to_s] ||= {}
  #       soundcloud_hash[i.to_s]["provider"] = "soundcloud"
  #       soundcloud_hash[i.to_s]["artist_name"] = artist.name
  #       soundcloud_hash[i.to_s]["track_name"] = track.title
  #       soundcloud_hash[i.to_s]["image_url"] = track.artwork_url
  #       soundcloud_hash[i.to_s]["release_date"] = Date.parse(track.created_at)
  #       soundcloud_hash[i.to_s]["track_url"] = track.permalink_url
  #     end
  #   end
  #   soundcloud_hash
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.info.id).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.info.id
    user.name = auth.info.display_name
    user.email = auth.info.email
    binding.pry
    user.image_url = auth.info.images.first.url
    user.profile_url = auth.info.external_urls[:spotify]
    user.oauth_token = auth["credentials"]["token"]
    user.oauth_expires_at = auth["credentials"]["expires_at"]
    user.oauth_refresh_token = auth["credentials"]["refresh_token"]
    user.save
    end
  end
end