class Api::V1::Customers::TransactionsAssociationController < ApplicationController

  def index
    transactions = Customer.find(params[:id]).transactions
    render json: TransactionSerializer.new(transactions).serializable_hash
  end
end
