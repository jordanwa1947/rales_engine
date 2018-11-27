FactoryBot.define do
  factory :transaction do
    references { "" }
    credit_card_number { 1 }
    credit_card_expiration_date { "2018-11-27" }
  end
end
