class Api::V1::InvoicesController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.all).serializable_hash
  end

  def show
    render json: InvoiceSerializer.new(Invoice.find(params[:id])).serializable_hash
  end 
end
