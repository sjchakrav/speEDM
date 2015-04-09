class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    @spotify_info = RSpotify::Artist.search(@artist.name).first
    @artist_user = ArtistUser.new
    @found_artist_user = ArtistUser.find_by(:artist_id => @artist.id, :user_id => current_user.id)
    client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
    @soundcloud_info = client.get('/tracks', :q => "#{@artist.name}", :licence => 'cc-by-sa')
  end
end
