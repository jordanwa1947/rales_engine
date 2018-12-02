class Api::V1::Transactions::InvoiceAssociationController < ApplicationController

  def show
    invoice = Transaction.find(params[:id]).invoice 
    render json: InvoiceSerializer.new(invoice).serializable_hash
  end
end
