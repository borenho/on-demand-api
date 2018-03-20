class MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :update, :destroy]

  # GET /merchants
  def index
    # Get merchant accounts created by the current user
    @merchants = current_user.merchants
    json_response(@merchants)
  end

  # POST /merchants
  def create
    # Create merchant accounts belonging to the current user
    @merchant = current_user.merchants.create!(merchant_params)
    json_response(@merchant, :created)
  end

  # GET /merchants/:id
  def show
    json_response(@merchant)
  end

  # PUT /merchants/:id
  def update
    @merchant.update!(merchant_params)
    head :no_content
  end

  # DELETE /merchants/:id
  def destroy
    @merchant.destroy
    head :no_content
  end


  private

  def merchant_params
    # Whitelist params
    params.permit(:name)
  end

  def set_merchant
    # Callback method to find a merchant by id
    @merchant = Merchant.find(params[:id])
  end
end

# TODOs
# Return a custom success message after merchant creation/update/deletion
# Return the updated record after a PUT request
