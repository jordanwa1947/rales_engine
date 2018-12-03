class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all).serializable_hash
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id])).serializable_hash
  end
end
