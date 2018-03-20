require 'rails_helper'

RSpec.describe AuthenticateUser do
  # Create user
  let(:user) { create(:user) }
  # Valid request subject
  subject(:valid_auth_object) { described_class.new(user.email, user.password) }
  # Invalid request subject
  subject(:invalid_auth_object) { described_class.new('foo', 'bar') }

  # Test suite for AuthenticateUser#call_api
  # Test suite for AuthenticateUser class
  describe AuthenticateUser do
    it 'is available as a described class' do
      expect(described_class).to eq(AuthenticateUser)
    end

    # Test suite for AuthorizeApiRequest#call_api
    # This is our entry point into the service class
    describe '#call_api' do
      # Return token when valid request
      context 'when valid credentials' do
        it 'returns auth token' do
          token = valid_auth_object.call_api
          expect(token).not_to be_nil
        end
      end

      # Raise AuthenticationError when invalid credentials
      context 'when invalid credentials' do
        it 'raises authentication error' do
          expect{ invalid_auth_object.call_api }
            .to raise_error(ExceptionHandler::AuthenticationError, /Invalid credentials/)
        end
      end
    end
  end
end
