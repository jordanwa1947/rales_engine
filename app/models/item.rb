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
end
