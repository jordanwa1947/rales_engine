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

  def total_single_merch_rev
    invoices
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'})
    .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')[0]
    .revenue
  end

  def total_merch_rev_by_date(date)
    invoices
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'})
    .where(invoices: {updated_at: date.beginning_of_day..date.end_of_day})
    .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')[0]
    .revenue
  end

  def find_favorite_customer
    invoices
    .select('customers.id AS id, COUNT(customers.id) AS transaction_count')
    .joins(:transactions)
    .joins('INNER JOIN customers ON invoices.customer_id = customers.id')
    .where(transactions: {result: 'success'})
    .group('customers.id')
    .order('transaction_count DESC')
    .limit(1)
  end

  def favorite_customer
    customer = find_favorite_customer
    Customer.find(customer[0].id)
  end
end
