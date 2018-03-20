# Define jwt singleton.
class JsonWebToken
    # Use HMAC_SECRET to encode and decode the token (every Rails app has a unique secret key, we'll use that as our secret to sign tokens)
    HMAC_SECRET = Rails.application.secrets.secret_key_base

    # JWT's encode method will create the tokens based on a payload (user id) and expiration period
    def self.encode(payload, exp=24.hours.from_now)
        # Set payload expiry time
        payload[:exp] = exp.to_i
        # Sign token with application secret
        JWT.encode(payload, HMAC_SECRET)
    end

    # JWT's decode method accepts the token and attempts to decode it using the same secret used in encoding
    def self.decode(auth_token)
        # Get payload - first item in the decoded array
        body = JWT.decode(auth_token, HMAC_SECRET)[0]
        HashWithIndifferentAccess.new body
        # Rescue from all decode errors
        rescue JWT::DecodeError => err
            # Raise custom error to be handled by custom error handler
            raise ExceptionHandler::InvalidToken, err.message
    end
end
