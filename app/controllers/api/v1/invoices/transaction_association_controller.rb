class Api::V1::Invoices::TransactionAssociationController < ApplicationController

  def index
    invoice_transactions = Invoice.find(params[:id]).transactions
    render json: TransactionSerializer.new(invoice_transactions).serializable_hash
  end
end
