class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price

  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.top_rev_items(limit_amount)
    select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS item_rev')
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group('items.id')
    .order('item_rev DESC')
    .limit(limit_amount)
  end

  def self.top_quant_items(limit_amount)
    select('items.*, COUNT(invoice_items.quantity) AS item_quant')
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .group('items.id')
    .order('item_quant DESC')
    .limit(limit_amount)
  end

  def top_rev_date_for_item(date)
    invoices
    .select('invoices.updated_at, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'})
    .group('invoices.updated_at')
    .order('revenue DESC')
    .limit(1)[0]
    .updated_at
  end
end
