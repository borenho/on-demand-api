require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
    # Create test user
    let(:user) { create(:user) }
    # Mock 'Authorization' header' using a cutom helper method 'token_generator'
    let(:header) {{ 'Authorization' => token_generator(user.id) }}
    # Invalid request subject
    subject(:invalid_request_obj) { described_class.new({}) }
    subject(:request_obj) { described_class.new(header) }

    # Test suite for AuthorizeApiRequest class
    describe AuthorizeApiRequest do
        it 'is available as a described class' do
            expect(described_class).to eq(AuthorizeApiRequest)
        end

        # Test suite for AuthorizeApiRequest#call_api
        # This is our entry point into the service class
        describe '#call_api' do
            # Returns user object when request is valid
            context 'when valid request' do
                it 'returns user object' do
                    result = request_obj.call_api
                    expect(result[:user]).to eq(user)
                end
            end
    
            # Returns error message when invalid request
            context 'when invalid request' do
                context 'when missing token' do
                    it 'raises a missing token error' do
                        expect { invalid_request_obj.call_api }
                            .to raise_error(ExceptionHandler::MissingToken, 'Missing Token')
                    end
                end
    
                context 'when invalid token' do
                    subject(:invalid_request_obj) do
                        described_class.new('Authorization' => token_generator(5))
                    end
    
                    it 'raises an InvalidToken error' do
                        expect { invalid_request_obj.call_api }
                            .to raise_error(ExceptionHandler::InvalidToken, /Invalid token/)
                    end
                end
    
                context 'when token is expired' do
                    let(:header) {{ 'Authorization' => expired_token_generator(user.id) }}
                    subject(:request_obj) { described_class.new(header) }
    
                    it 'raises ExceptionHandler::ExpiredSignatureError' do
                        expect { invalid_request_obj.call_api }
                            .to raise_error(ExceptionHandler::InvalidToken, /Signature has expired/)
                    end
                end
    
                context 'fake token' do
                    let(:header) {{ 'Authorization' => 'foobar' }}
                    subject(:invalid_request_obj) { described_class.new(header) }
    
                    it 'handles JWT::DecodeError' do
                        expect { invalid_request_obj.call_api }
                            .to raise_error(ExceptionHandler::InvalidToken, /Not enough or too many segments/)
                    end
                end
            end
        end
    end
end
