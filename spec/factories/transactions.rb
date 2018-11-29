FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { 1 }
    result { "success" }
    credit_card_expiration_date { "2018-11-27" }
  end
end
