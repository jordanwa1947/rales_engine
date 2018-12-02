class AddMerchantReference < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :merchant, index: true
  end
end
