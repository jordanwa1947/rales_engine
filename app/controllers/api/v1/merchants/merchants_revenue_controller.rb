class Api::V1::Merchants::MerchantsRevenueController < ApplicationController

  def index
    merchants = Merchant.top_merch_by_rev(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash
  end

  def show
    if params[:date] && params[:id]
      merchant = Merchant.find(params[:id])
      revenue = merchant.total_merch_rev_by_date(Date.strptime(params[:date]))
      revenue ? digestible = (revenue / 100.0).round(2).to_s : digestible = 0
      hash = { "data" => { "attributes" => { "revenue" => digestible }}}
      render json: hash
    elsif params[:id]
      merchant = Merchant.find(params[:id])
      revenue = merchant.total_single_merch_rev
      revenue ? digestible = (revenue / 100.0).round(2).to_s : digestible = 0
      hash = { "data" => { "attributes" => { "revenue" => digestible }}}
      render json: hash
    else
      revenue = Merchant.total_rev_by_date(Date.strptime(params[:date]))
      revenue ? digestible = (revenue / 100.0).round(2).to_s : digestible = 0
      hash = { "data" => { "attributes" => { "total_revenue" => digestible }}}
      render json: hash
    end
  end
end
