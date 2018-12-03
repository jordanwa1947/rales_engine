class Api::V1::Items::FindController < ApplicationController

  def show
    item = Item.find_by_given_param(item_params)
    render json: ItemSerializer.new(item).serializable_hash
  end

  def index
    item = Item.find_all_by_given_param(item_params)
    render json: ItemSerializer.new(item).serializable_hash
  end

  private

  def item_params
    params.permit( :name,
                   :description,
                   :unit_price,
                   :created_at,
                   :updated_at,
                   :merchant_id,
                   :id)
  end
end
