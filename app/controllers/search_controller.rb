class SearchController < ApplicationController
  def search
    @artist = Artist.find_by(:slug => search_params["name"].downcase.gsub(/[^a-z1-9$]+/, '-').chomp('-'))
    unless @artist
      found = RSpotify::Artist.search(search_params["name"]).first
      @artist = Artist.create_artist_from_spotify(found.name, found.images[0]["url"], found.external_urls["spotify"])
    end
    redirect_to artist_path(@artist)
  end

  private

  def search_params
    params.require(:search).permit(:name)
  end
end
