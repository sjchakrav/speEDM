class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @artists = @user.artists.all
    @client = Soundcloud.new(:client_id => ENV['SOUNDCLOUD_ID'])
  end
end
