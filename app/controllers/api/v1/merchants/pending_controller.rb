class Api::V1::Merchants::PendingController < ApplicationController

  def index
    customers = Merchant.customers_with_pending_invoices(params[:id])
    render json: CustomerSerializer.new(customers).serializable_hash
  end
end
