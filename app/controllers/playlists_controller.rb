class PlaylistsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    @playlist = @user.playlists.find(params[:id])
  end
end
