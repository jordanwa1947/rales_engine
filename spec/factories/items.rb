FactoryBot.define do
  factory :item do
    merchant
    name { "Item" }
    description { "My Item Text" }
    unit_price { 1 }
  end
end
