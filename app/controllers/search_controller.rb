class SearchController < ApplicationController
  def search
    @artist = Artist.find_by(slug: normalized_artist_name)

    unless @artist
      found = RSpotify::Artist.search(search_params["name"]).first
      persist_artist(found)
      Track.create_tracks(@artist)
    end

    redirect_to artist_path(@artist)
  end

  private

  def normalized_artist_name
    search_params["name"].downcase.gsub(/[^a-z1-9$]+/, '-').chomp('-')
  end

  def persist_artist(artist)
    image_url = artist.images.empty? ? nil : artist.images[0]['url']

    @artist = Artist.create_artist_from_spotify(
                artist.name,
                image_url,
                artist.external_urls["spotify"])
  end

  def search_params
    params.require(:search).permit(:name)
  end
end
