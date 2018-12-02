class Api::V1::InvoiceItems::InvoiceAssociationController < ApplicationController

  def show
    invoice = InvoiceItem.find(params[:id]).invoice
    render json: InvoiceSerializer.new(invoice).serializable_hash
  end
end
