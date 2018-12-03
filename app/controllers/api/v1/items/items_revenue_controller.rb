class Api::V1::Items::ItemsRevenueController < ApplicationController

  def index
    items = Item.top_rev_items(params[:quantity])
    render json: ItemSerializer.new(items).serializable_hash
  end
end
