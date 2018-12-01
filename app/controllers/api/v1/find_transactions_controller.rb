class Api::V1::FindTransactionsController < ApplicationController

  def index

  end

  def show
    render json: TransactionSerializer.new(Transaction.find_by_given_param(query_params)).serializable_hash
  end

  private
    def query_params
      params.permit(:invoice,
                    :credit_card_number,
                    :credit_card_expiration_date,
                    :created_at,
                    :updated_at,
                    :result,
                    :id)
    end
end
