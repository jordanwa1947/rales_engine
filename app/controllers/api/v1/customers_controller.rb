class Api::V1::CustomersController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all).serializable_hash
  end
end
