class Api::V1::Customers::FindController < ApplicationController

  def show
    customer = Customer.find_by_given_param(customer_params)
    render json: CustomerSerializer.new(customer).serializable_hash
  end

  def index
    customers = Customer.find_all_by_given_param(customer_params)
    render json: CustomerSerializer.new(customers).serializable_hash
  end

  private

  def customer_params
    params.permit(:first_name,
                  :last_name,
                  :created_at,
                  :updated_at,
                  :id)
  end
end
