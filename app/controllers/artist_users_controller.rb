class ArtistUsersController < ApplicationController
  def create
    ArtistUser.find_or_create_by(:user_id => params[:artist_user][:user_id], :artist_id => params[:artist_user][:artist_id])
    redirect_to user_path(current_user)
  end
end
