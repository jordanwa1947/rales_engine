class Api::V1::InvoiceItems::FindController < ApplicationController

  def show
    invoice_item = InvoiceItem.find_by_given_param(invoice_item_params)
    render json: InvoiceItemSerializer.new(invoice_item).serializable_hash
  end

  def index
    invoice_items = InvoiceItem.find_all_by_given_param(invoice_item_params)
    render json: InvoiceItemSerializer.new(invoice_items).serializable_hash
  end

  private

  def invoice_item_params
    params.permit(:item_id,
                  :invoice_id,
                  :quantity,
                  :unit_price,
                  :created_at,
                  :updated_at,
                  :id)
  end
end
