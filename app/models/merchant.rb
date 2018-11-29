class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :invoices
  has_many :customers, through: :invoices

  def self.top_merch_by_rev(limit_amount)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue')
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group('merchants.id')
    .order('merchant_revenue DESC')
    .limit(limit_amount)
  end

  def self.top_merch_by_quantity(limit_amount)
    select('merchants.*, SUM(invoice_items.quantity) AS merchant_quant')
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group('merchants.id')
    .order('merchant_quant DESC')
    .limit(limit_amount)
  end

  def self.total_rev_by_date(date = Date.today)
    joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .where(invoices: {updated_at: date.beginning_of_day..date.end_of_day})
    .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS date_revenue')[0]
    .date_revenue
  end
end
