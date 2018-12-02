class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices
  has_many :merchants, through: :invoices

  extend FindMethods

  def favorite_customer_merchant(customer_id)
    Merchant.select('merchants.*, COUNT(transactions.id) AS merchant_transactions')
    .joins(invoices: [:transactions])
    .where(invoices: {customer_id: customer_id})
    .where(transactions: {result: 'success'})
    .group('merchants.id')
    .order('merchant_transactions DESC')
    .limit(1)
  end
end
