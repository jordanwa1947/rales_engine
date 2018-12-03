class Api::V1::Items::ItemsSoldController < ApplicationController

  def index
    items = Item.top_quant_items(params[:quantity])
    render json: ItemSerializer.new(items).serializable_hash
  end
end
