FactoryBot.define do
  factory :transaction do
    invoice
    sequence(:credit_card_number) { |n| n}
    result { "success" }
    credit_card_expiration_date { "2018-11-27" }
  end
end
