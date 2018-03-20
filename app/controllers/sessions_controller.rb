class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_by_auth(auth_hash)
    session[:user_id] = @user_id

    redirect_to '/', notice: 'Logged in as #{@user.name}'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
