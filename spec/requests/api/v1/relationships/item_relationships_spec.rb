require 'rails_helper'

describe 'Item Relations' do
  describe 'AssociationControllers' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant, name: "Turing")

      customer = create(:customer)

      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success')
      @invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success')
      @invoice_3 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
      @invoice_4 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
      @invoice_5 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success')
      @invoice_6 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success')

      create(:transaction, invoice_id: @invoice_1.id)
      create(:transaction, invoice_id: @invoice_2.id)
      create(:transaction, invoice_id: @invoice_3.id)
      create(:transaction, invoice_id: @invoice_3.id)
      create(:transaction, invoice_id: @invoice_5.id)
      create(:transaction, invoice_id: @invoice_3.id)

      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_2.id)
      @item_3 = create(:item, merchant_id: @merchant_1.id)
      @item_4 = create(:item, merchant_id: @merchant_2.id)

      create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 16, unit_price: 50)
      create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id, quantity: 10, unit_price: 50)
      create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 300)
      create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_4.id, quantity: 12, unit_price: 300)
      create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_3.id, quantity: 8, unit_price: 200)
      create(:invoice_item, invoice_id: @invoice_6.id, item_id: @item_2.id, quantity: 5, unit_price: 200)
    end

    it 'responds with a collection of associated invoice_items' do

      get "/api/v1/items/#{@item_2.id}/invoice_items"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)
      expect(invoice_items['data'].count).to eq(2)
    end
  end
end
