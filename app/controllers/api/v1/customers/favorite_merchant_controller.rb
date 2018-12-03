class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    customer = Customer.find(params[:id])
    merchant = customer.favorite_customer_merchant(customer.id)[0]
    render json: MerchantSerializer.new(merchant).serializable_hash
  end
end
