class Api::V1::Invoices::CustomerAssociationController < ApplicationController

  def show
    customer = Invoice.find(params[:id]).customer
    render json: CustomerSerializer.new(customer).serializable_hash
  end
end
