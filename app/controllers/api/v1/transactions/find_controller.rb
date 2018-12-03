class Api::V1::Transactions::FindController < ApplicationController

  def index
    transaction = Transaction.find_all_by_given_param(query_params)
    render json: TransactionSerializer.new(transaction).serializable_hash
  end

  def show
    transactions = Transaction.find_by_given_param(query_params)
    render json: TransactionSerializer.new(transactions).serializable_hash
  end

  private
    def query_params
      params.permit(:invoice_id,
                    :credit_card_number,
                    :credit_card_expiration_date,
                    :created_at,
                    :updated_at,
                    :result,
                    :id)
    end
end
