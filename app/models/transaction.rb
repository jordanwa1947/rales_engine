class Transaction < ApplicationRecord
  validates_presence_of :invoice_id, :credit_card_number

  belongs_to :invoice

  extend FindMethods
end
