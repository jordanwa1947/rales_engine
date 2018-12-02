class Api::V1::Merchants::ItemsAssociationController < ApplicationController
  def index
    merchant_items = Merchant.find(params[:id]).items
    render json: ItemSerializer.new(merchant_items).serializable_hash
  end
end
