class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    @spotify_tracks = @artist.spotify_tracks
    @per_page = params[:per_page] || 20
    @soundcloud_tracks = @artist.soundcloud_tracks.paginate(:per_page => @per_page, :page => params[:soundcloud_page])
    @artist_user = ArtistUser.new
    @found_artist_user = ArtistUser.find_by(:artist_id => @artist.id, :user_id => current_user.id)
  end
end
