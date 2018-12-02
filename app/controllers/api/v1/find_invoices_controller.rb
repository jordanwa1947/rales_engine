class Api::V1::FindInvoicesController < ApplicationController

  def show
    invoice = Invoice.find_by_given_param(invoice_params)
    render json: InvoiceSerializer.new(invoice).serializable_hash
  end

  def index
    invoices = Invoice.find_all_by_given_param(invoice_params)
    render json: InvoiceSerializer.new(invoices).serializable_hash
  end

  private

  def invoice_params
    params.permit(:merchant_id,
                  :customer_id,
                  :status,
                  :created_at,
                  :updated_at,
                  :id)
  end
end
