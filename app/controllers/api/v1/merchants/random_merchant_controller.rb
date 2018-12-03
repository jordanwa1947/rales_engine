class Api::V1::Merchants::RandomMerchantController < ApplicationController

  def show
    random = Merchant.all.sample(1)
    render json: MerchantSerializer.new(random).serializable_hash
  end
end
