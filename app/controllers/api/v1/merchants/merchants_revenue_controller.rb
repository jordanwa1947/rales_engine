class Api::V1::Merchants::MerchantsRevenueController < ApplicationController

  def index
    merchants = Merchant.top_merch_by_rev(params[:quantity])
    render json: MerchantSerializer.new(merchants).serializable_hash
  end

  def show
    revenue = Merchant.total_rev_by_date(Date.strptime(params[:date]))
    digestible = (revenue / 100.0).round(2).to_s
    hash = { "data" => { "attributes" => { "total_revenue" => digestible }}}
    render json: hash
  end
end
