class Api::V1::CustomersController < ApplicationController

  def index
    render json: CustomerSerializer.new(Customer.all).serializable_hash
  end

  def show
    render json: CustomerSerializer.new(Customer.find(params[:id])).serializable_hash
  end
end
