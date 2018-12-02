class ItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :description,
             :name,
             :unit_price, 
             :merchant_id
end
