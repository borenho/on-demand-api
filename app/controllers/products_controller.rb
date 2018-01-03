class ProductsController < ApplicationController
    before_action :set_merchant
    before_action :set_product, only: [:show, :update, :destroy]

    # GET /merchants/:merchant_id/products
    def index
        json_response(@merchant.products)
    end

    # GET /merchants/:merchant_id/products/:product_id
    def show
        json_response(@product)
    end

    # POST /merchants/:merchant_id/products
    def create
        @merchant.products.create!(product_params)
        json_response(@merchant, :created)  # TODO return the created product, not the merchant
    end

    # PUT /merchants/:merchant_id/products/:product_id
    def update
        @product.update(product_params)
        head :no_content
    end

    # DELETE /merchants/:merchant_id/products/:product_id
    def destroy
        @product.destroy
        head :no_content
    end


    private

    def product_params
        params.permit(:name, :price)
    end

    def set_merchant
        @merchant = Merchant.find(params[:merchant_id])
    end

    def set_product
        @product = @merchant.products.find_by!(id: params[:id]) if @merchant
    end
end

# TODOs
# Return a custom success message after product creation/update/deletion
# Return the updated record after a PUT request
