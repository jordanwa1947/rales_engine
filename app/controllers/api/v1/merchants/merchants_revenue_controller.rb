class Api::V1::Merchants::MerchantsRevenueController < ApplicationController

  def index
    merchants = Merchant.top_merch_by_rev(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash
  end
end
