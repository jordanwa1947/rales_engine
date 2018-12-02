class Api::V1::Invoices::MerchantAssociationController < ApplicationController

  def show
    merchant = Invoice.find(params[:id]).merchant
    render json: MerchantSerializer.new(merchant).serializable_hash
  end
end
