class Api::V1::Items::MerchantAssociationController < ApplicationController

  def show
    merchant = Item.find(params[:id]).merchant
    render json: MerchantSerializer.new(merchant).serializable_hash
  end
end
