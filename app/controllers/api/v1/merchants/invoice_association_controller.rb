class Api::V1::Merchants::InvoiceAssociationController < ApplicationController

  def index
    merchant_invoices = Merchant.find(params[:id]).invoices
    render json: InvoiceSerializer.new(merchant_invoices).serializable_hash
  end
end
