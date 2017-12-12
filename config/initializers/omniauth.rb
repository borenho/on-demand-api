Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, '114145759178-vjtc8i9290bp7atv9vson6dd0plnus6e.apps.googleusercontent.com', 'F4EaYcfto7gL2f8NvV_Ec2RQ',
        {
            name: 'google',
            scope: 'email, profile, plus.me',
            prompt: 'select_account',
            image_aspect_ratio: 'square',
            image_size: 50
        }
end

# Fix protocol mismatch for redirect_uri
OmniAuth.config.full_host = Rails.env.production ? 'https://on-demand-api.com' : 'http:localhost/3000'

# On both iOS and Android
 # send an additional parameter redirect_uri= (empty string) to the /auth/google_oauth2/callback URL from your mobile device

# CORS
# If you're making POST requests to /auth/google_oauth2/callback from another domain, then you need to make sure
# 'X-Requested-With': 'XMLHttpRequest' header is included with your request, otherwise your server might respond with 
# OAuth2::Error, : Invalid Value error.
