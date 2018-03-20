require 'rails_helper'

RSpec.describe 'Products API' do
    # Initialize test data
    let(:user) { create(:user) }
    let!(:merchant) { create(:merchant, created_by: user.id) }
    let!(:products) { create_list(:product, 20, merchant_id: merchant.id) }
    let!(:merchant_id) { merchant.id }
    let(:product_id) { products.first.id }
    let(:headers) { valid_headers }

    # GET /merchants/:merchant_id/products
    describe 'GET /merchants/:merchant_id/products' do
        before { get "/merchants/#{merchant_id}/products", params: {}, headers: headers }

        context 'when merchant exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it "returns all the merchant's products" do
                expect(json.size).to eq(20)
            end
        end

        context 'when merchant does not exist' do
            let!(:merchant_id) { 0 }

            it 'return status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found error message' do
                expect(response.body).to match(/Couldn't find Merchant/)
            end
        end
    end

    # GET /merchants/:merchant_id/products/:product_id
    describe 'GET /merchants/:merchant_id/products/product_id' do
        before { get "/merchants/#{merchant_id}/products/#{product_id}", params: {}, headers: headers }

        context 'when product exists' do
            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end

            it "returns the product" do
                expect(json['id']).to eq(product_id)
            end
        end

        context 'when product does not exist' do
            let(:product_id) { 0 }

            it 'return status code 404' do
                expect(response).to have_http_status(404)
            end

            it "returns a not found error message" do
                expect(response.body).to match(/Couldn't find Product/)
            end
        end
    end

    # POST /merchants/:merchant_id/products
    describe 'POST /merchants/:merchant_id/products' do
        let(:valid_attributes) { { name: '3 Bedroom', price: 20_000 }.to_json }

        context 'when request attributes are valid' do
            before { post "/merchants/#{merchant_id}/products", params: valid_attributes, headers: headers }

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end

            it "returns the created product" do
                expect(json).not_to be_empty
            end
        end

        context 'when the request is invalid' do
            before { post "/merchants/#{merchant_id}/products", params: {}, headers: headers }

            it 'return status code 422' do
                expect(response).to have_http_status(422)
            end

            it "returns a validation error message" do
                expect(response.body).to match(/Validation failed: Name can't be blank/)
            end
        end
    end

    # PUT /merchants/:merchant_id/products/:product_id
    describe 'PUT /merchants/:merchant_id/products/:product_id' do
        let(:valid_attributes) { { name: 'Air Bnb', price: 50_000 }.to_json }

        before { put "/merchants/#{merchant_id}/products/#{product_id}", params: valid_attributes, headers: headers }

        context 'when item exists' do

            it 'return status code 204' do
                expect(response).to have_http_status(204)
            end

            it 'updates the product' do
                updated_product = Product.find(product_id)
                expect(updated_product.name).to match(/Air Bnb/)
            end
        end

        context 'when the product does not exist' do
            let(:product_id) { 0 }

            it 'return status code 404' do
                expect(response).to have_http_status(404)
            end

            it "returns a not found error message" do
                expect(response.body).to match(/Couldn't find Product/)
            end
        end
    end

    # DELETE /merchants/:merchant_id/products/:product_id
    describe 'DELETE /merchants/:merchant_id/products/:product_id' do
        before { delete "/merchants/#{merchant_id}/products/#{product_id}", params: {}, headers: headers }

        it 'returns a status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end

# TODOs
# Return a custom success message after product creation/update/deletion
# Return the updated record after a PUT request
