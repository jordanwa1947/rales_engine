class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :credit_card_number

  belongs_to :invoice

  def self.find_by_given_param(query_params)
    query = query_params.to_h.first
    transaction = find_by("#{query[0]} = ?", query[1])
    transaction
  end
end
