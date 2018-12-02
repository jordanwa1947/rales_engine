class Api::V1::InvoiceItems::ItemAssociationController < ApplicationController

  def show
    item = InvoiceItem.find(params[:id]).item
    render json: ItemSerializer.new(item).serializable_hash
  end
end
