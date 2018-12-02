class Api::V1::Merchants::MerchantsSoldController < ApplicationController

  def index
    merchants = Merchant.top_merch_by_quantity(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash
  end
end
