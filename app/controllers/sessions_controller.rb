class SessionsController < ApplicationController
  def create
    data = request.env["omniauth.auth"]
    # binding.pry
    # test = RSpotify::User.new(request.env["omniauth.auth"])
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to user_path(user)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end