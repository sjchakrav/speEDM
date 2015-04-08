class SearchController < ApplicationController
  def search
    @artist = Artist.find_by(:slug => params[:search][:name].downcase.gsub(/[^a-z1-9$]+/, '-').chomp('-'))
    unless @artist
      found = RSpotify::Artist.search(params[:search][:name]).first
      @artist = Artist.create_artist_from_spotify(found.name, found.images[0]["url"], found.external_urls["spotify"])
    end
    redirect_to artist_path(@artist)
  end
end
