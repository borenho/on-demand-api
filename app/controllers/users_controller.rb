class UsersController < ApplicationController
    # POST /auth/signup
    # Return auth token after successful signup
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call_api
    response = { message: Message.account_created, auth_token: auth_token }

    json_response(response, :created)


    private

    def user_params
        params.permit(:name, :email, :password, :password_confirmation)
    end
end
