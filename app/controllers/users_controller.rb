require 'will_paginate/array'
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @per_page = params[:per_page] || 10
    @spotify_tracks = @user.list_tracks("spotify").paginate(:per_page => @per_page, :page => params[:spotify_page])
    @soundcloud_tracks = @user.list_tracks("soundcloud").paginate(:per_page => @per_page, :page => params[:soundcloud_page])
  end
end
