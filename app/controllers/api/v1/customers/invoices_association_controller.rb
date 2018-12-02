class Api::V1::Customers::InvoicesAssociationController < ApplicationController

  def index
    invoices = Customer.find(params[:id]).invoices
    render json: InvoiceSerializer.new(invoices).serializable_hash
  end
end
