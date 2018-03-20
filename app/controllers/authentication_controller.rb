class AuthenticationController < ApplicationController
  # To hit /auth/login we wont need a token, so skip authorizeapirequest
  skip_before_action :authorize_request, only: :authenticate

  # Return an auth token once user is authenticated
  def authenticate
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call_api
    json_response(auth_token: auth_token)
  end


  private

  def auth_params
    params.permit(:email, :password)
  end
end
