class Api::V1::Invoices::ItemsAssociationController < ApplicationController

  def index
    invoice_items = Invoice.find(params[:id]).items
    render json: ItemSerializer.new(invoice_items).serializable_hash
  end
end
