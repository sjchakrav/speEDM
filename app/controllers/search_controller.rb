class SearchController < ApplicationController

  def search    
    @artist_searched = RSpotify::Artist.search(params[:search][:name]).first 
    @artist = Artist.make_artist_from_spotify(@artist_searched)
    # save the artist or whatever to the database
    # @artist = Artist.new
    # @artist.name = @artist_searched# stuff here
    # redirect to the artist 
    redirect_to artist_path(@artist)
  end

end
