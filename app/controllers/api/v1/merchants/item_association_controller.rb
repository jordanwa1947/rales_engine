class Api::V1::Merchants::ItemAssociationController < ApplicationController
  def index
    merchant_items = Merchant.find(params[:id]).items.distinct
    render json: ItemSerializer.new(merchant_items).serializable_hash
  end
end
