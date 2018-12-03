class Api::V1::Items::ItemDateController < ApplicationController

  def show
    item = Item.find(params[:id])
    date = item.top_rev_date_for_item
    hash = ItemSerializer.new(item).serializable_hash
    hash[:data][:attributes][:best_day] = date
    render json: hash 
  end
end
