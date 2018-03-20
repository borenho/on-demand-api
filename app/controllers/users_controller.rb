class UsersController < ApplicationController
    # To hit /auth/signup we wont need a token, so skip authorizeapirequest
    skip_before_action :authorize_request, only: :create

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call_api
    response = { message: Message.account_created, auth_token: auth_token }

    json_response(response, :created)
  end


  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
