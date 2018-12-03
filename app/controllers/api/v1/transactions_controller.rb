class Api::V1::TransactionsController < ApplicationController
  def index
    render json: TransactionSerializer.new(Transaction.all).serializable_hash
  end

  def show
    render json: TransactionSerializer.new(Transaction.find(params[:id])).serializable_hash
  end
end
