class ArtistUsersController < ApplicationController
  def create
    ArtistUser.find_or_create_by(artist_user_params)
    redirect_to user_path(current_user)
  end

  def destroy
    @artist_user = ArtistUser.find(params[:id])
    @artist = @artist_user.artist
    @artist_user.destroy
    redirect_to artist_path(@artist)
  end

  private

  def artist_user_params
    params.require(:artist_user).permit(:artist_id, :user_id)
  end
end
