require 'rails_helper'

describe 'Customer Association Api Requests' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @customer = create(:customer)

    invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer.id, status: 'success')
    invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id, status: 'success')
    invoice_3 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
    invoice_4 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
    invoice_5 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer.id, status: 'success')
    invoice_6 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id, status: 'success')

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, invoice_id: invoice_4.id)
    create(:transaction, invoice_id: invoice_5.id)
    create(:transaction, invoice_id: invoice_6.id)

    @item_1 = create(:item)
    @item_2 = create(:item)
    @item_3 = create(:item)
    @item_4 = create(:item)

    create(:invoice_item, invoice_id: invoice_1.id, item_id: @item_1.id, quantity: 16, unit_price: 50)
    create(:invoice_item, invoice_id: invoice_2.id, item_id: @item_2.id, quantity: 10, unit_price: 50)
    create(:invoice_item, invoice_id: invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 300)
    create(:invoice_item, invoice_id: invoice_4.id, item_id: @item_4.id, quantity: 12, unit_price: 300)
    create(:invoice_item, invoice_id: invoice_5.id, item_id: @item_3.id, quantity: 8, unit_price: 200)
    create(:invoice_item, invoice_id: invoice_6.id, item_id: @item_2.id, quantity: 5, unit_price: 200)
  end

  it 'returns invoices associated with a customer' do

    get "/api/v1/customers/#{@customer.id}/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices['data'].count).to eq(6)
  end

  it 'returns transactions associated with a customer' do

    get "/api/v1/customers/#{@customer.id}/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions['data'].count).to eq(6)
  end
end
