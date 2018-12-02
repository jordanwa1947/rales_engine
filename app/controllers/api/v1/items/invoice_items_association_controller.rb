class Api::V1::Items::InvoiceItemsAssociationController < ApplicationController

  def index
    invoice_items = Item.find(params[:id]).invoice_items
    render json: InvoiceItemSerializer.new(invoice_items).serializable_hash
  end
end
