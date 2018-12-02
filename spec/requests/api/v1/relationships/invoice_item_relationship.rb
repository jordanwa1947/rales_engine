require 'rails_helper'

describe 'Merchant Relation Api Requests' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    customer = create(:customer)

    invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success')
    invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success')
    invoice_3 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success')
    invoice_4 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
    invoice_5 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success')
    invoice_6 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success')

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, invoice_id: invoice_4.id)
    create(:transaction, invoice_id: invoice_5.id)
    create(:transaction, invoice_id: invoice_6.id)

    @item_1 = create(:item)
    @item_2 = create(:item)
    @item_3 = create(:item)
    @item_4 = create(:item, name: "Rock em Sock em")

    create(:invoice_item, invoice_id: invoice_1.id, item_id: @item_1.id, quantity: 16, unit_price: 50)
    create(:invoice_item, invoice_id: invoice_2.id, item_id: @item_2.id, quantity: 10, unit_price: 50)
    create(:invoice_item, invoice_id: invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 300)
    @invoice_item = create(:invoice_item, invoice_id: invoice_4.id, item_id: @item_4.id, quantity: 12, unit_price: 300)
    create(:invoice_item, invoice_id: invoice_5.id, item_id: @item_3.id, quantity: 8, unit_price: 200)
    create(:invoice_item, invoice_id: invoice_6.id, item_id: @item_2.id, quantity: 5, unit_price: 200)
  end

  it 'returns the item associated with and invoice_item' do

    get "/api/v1/invoice_items/#{@invoice_item.id}/item", to: 'item_association#show'

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item['data']['attributes']['name']).to eq("Rock em Sock em"))
  end

  it 'returns the invoice associated an invoice_item' do

    get "/api/v1/invoice_items/#{@invoice_item.id}/invoice", to: 'invoice_association#show'

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice['data']['attributes']['updated_at']).to eq(1.day.ago))
  end
end
