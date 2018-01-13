class AuthorizeApiRequest
    def initialize(headers = {})
        @headers = headers
    end

    # Service entry point to return a valid user object
    def call_api
        {
            user: user
        }
    end


    private

    attr_reader :headers

    def user
        # Check if user is in the db, memoize the user object if so
        @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
        # Handle user not found
        rescue ActiveRecord::RecordNotFound => err
            # Raise custom error
            raise(ExceptionHandler::InvalidToken, ("#{ message.invalid_token } #{ err.message }"))

    end

    # Decode the token
    def decoded_auth_token
        @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    # Check for token in authorization header
    def http_auth_header
        if headers['Authorizaton'].present?
            return headers['Authorization'].split(' ').last
        end

        raise(ExceptionHandler::MissingToken, Message.missing_token)
    end
end
