class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :description,
             :name,
             :unit_price,
             :merchant_id

  attribute :unit_price do |price|
    (price.unit_price / 100.0).round(2).to_s
  end
end
