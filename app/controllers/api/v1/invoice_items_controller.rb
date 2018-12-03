class Api::V1::InvoiceItemsController < ApplicationController
  def index
    render json: InvoiceItemSerializer.new(InvoiceItem.all).serializable_hash
  end

  def show
    render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id])).serializable_hash
  end
end
