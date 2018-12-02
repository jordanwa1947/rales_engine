class Api::V1::Merchants::FindController < ApplicationController

  def show
    merchant = Merchant.find_by_given_param(merchant_params)
    render json: MerchantSerializer.new(merchant).serializable_hash
  end

  def index
    merchants = Merchant.find_all_by_given_param(merchant_params)
    render json: MerchantSerializer.new(merchants).serializable_hash
  end

  private

  def merchant_params
    params.permit(:name,
                  :created_at,
                  :updated_at,
                  :id)
  end
end
