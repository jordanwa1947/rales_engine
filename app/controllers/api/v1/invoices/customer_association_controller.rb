class Api::V1::Invoices::CustomerAssociationController < ApplicationController

  def index
    customer = Invoice.find(params[:id]).customer 
    render json: CustomerSerializer.new(customer).serializable_hash
  end
end
