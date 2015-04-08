class SearchController < ApplicationController

  def search
    @artist = Artist.where("name = 'params[:search][:name]'")
    unless @artist
      found = RSpotify::Artist.search(params[:search][:name]).first
      @artist = self.create_artist_from_spotify(found.name, found.image_url, found.profile_url)
    end
    redirect_to artist_path(@artist)

    # @artist = # find it
    # unless @artist
    #   @artist_searched = RSpotify::Artist.search(params[:search][:name]).first 
    #    @artist = Artist.make_artist_from_spotify(@artist_searched)
    # end
    # redirect_to artist_path(@artist)

    # save the artist or whatever to the database
    # @artist = Artist.new
    # @artist.name = @artist_searched# stuff here
    # redirect to the artist 
  end

end
