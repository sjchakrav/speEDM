class ArtistsController < ApplicationController
  def show
    @artist = Artist.find(params[:id])
    @spotify_info = RSpotify::Artist.search(@artist.name).first
  end
end
