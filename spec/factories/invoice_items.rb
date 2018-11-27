FactoryBot.define do
  factory :invoice_item do
    references { "" }
    references { "" }
    quantity { 1 }
    unit_price { 1 }
  end
end
