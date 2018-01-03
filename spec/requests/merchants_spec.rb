require 'rails_helper'

RSpec.describe 'Merchants API', type: :request do
    # Initialize test data
    let!(:merchants) { create_list(:merchant, 10) }
    let(:merchant_id) { merchants.first.id }

    # Test suite for GET /merchants
    describe 'GET /merchants' do
        # Make an HTTP get request before each example
        before { get '/merchants' }

        it 'returns merchants' do
            # Note that `json` is a custom helper to parse JSON responses
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # GET /merchants/:id
    describe 'GET /merchants/:id' do
        before { get "/merchants/#{merchant_id}" }

        context 'when the record exists' do
            it 'returns the merchant' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(merchant_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:merchant_id) { 100 }

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Merchant/)
            end

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    # POST /merchants
    describe 'POST /merchants' do
        # Send with it a valid payload
        let(:valid_attributes) { { name: 'Kaspersky Stores', created_by: '1' } }

        context 'when the request is valid' do
            before { post '/merchants', params: valid_attributes }

            it 'creates a merchant' do
                expect(json['name']).to eq('Kaspersky Stores')
            end

            it 'returns the created merchant' do
                expect(json). not_to be_empty
            end

            it 'returns a merchant created successfully message' do
                expect(response.message).to match('Created')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post '/merchants', params: { name: 'Kasp Ersky'} }

            it 'returns a validation error message' do
                expect(response.body).to match(/Validation failed: Created by can't be blank/)
            end

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

    # PUT /merchants/:id
    describe 'PUT /merchants/:id' do
        let(:valid_attributes) { { name: 'Kas Persky' } }

        context 'when the record exists' do
            before { put "/merchants/#{merchant_id}", params: valid_attributes }

            it 'updates the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response). to have_http_status(204)
            end
        end
    end

    # DELETE /merchants/:id
    describe 'DELETE /merchants/:id' do
        before { delete "/merchants/#{merchant_id}" }

        it 'returns statis code 204' do
            expect(response).to have_http_status(204)
        end
    end
end

# TODOs
# Return a custom success message after merchant creation/update/deletion
# Return the updated record after a PUT request
