class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all).serializable_hash
  end
end
