class Api::V1::FindCustomersController < ApplicationController

  def show
    customer = Customer.find_by_given_param(customer_params)
    render json: CustomerSerializer.new(customer).serializable_hash
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
