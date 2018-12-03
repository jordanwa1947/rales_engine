require 'rails_helper'

describe 'Merchant Business Logic Api Requests' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @merchant_3 = create(:merchant)

    @customer = create(:customer)

    invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: @customer.id, status: 'success', created_at: 3.days.ago, updated_at: 2.days.ago)
    invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id, status: 'success', created_at: 3.days.ago, updated_at: Date.today)
    invoice_3 = create(:invoice, merchant_id: @merchant_2.id, customer_id: @customer.id, status: 'success', created_at: 3.days.ago, updated_at: Date.today)
    invoice_4 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id, status: 'success', created_at: 3.days.ago, updated_at: Date.today)
    invoice_5 = create(:invoice, merchant_id: @merchant_3.id, customer_id: @customer.id, status: 'success', created_at: 3.days.ago, updated_at: Date.today)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id)
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, invoice_id: invoice_4.id)
    create(:transaction, invoice_id: invoice_5.id)

    item = create(:item)

    create(:invoice_item, invoice_id: invoice_1.id, item_id: item.id, quantity: 16, unit_price: 50)
    create(:invoice_item, invoice_id: invoice_2.id, item_id: item.id, quantity: 2, unit_price: 300)
    create(:invoice_item, invoice_id: invoice_3.id, item_id: item.id, quantity: 12, unit_price: 200)
    create(:invoice_item, invoice_id: invoice_4.id, item_id: item.id, quantity: 10, unit_price: 100)
    create(:invoice_item, invoice_id: invoice_5.id, item_id: item.id, quantity: 5, unit_price: 100)
  end

  it 'returns the selected amount of top merchants by revenue' do

    get '/api/v1/merchants/most_revenue?quantity=3'

    expect(response).to be_successful

    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data'].count).to eq(3)
  end

  it 'returns the selected amount of top merchants by items sold' do

    get '/api/v1/merchants/most_items?quantity=3'

    expect(response).to be_successful

    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data'].count).to eq(3)
  end

  it 'returns the revenue of all merchants for a selected date' do

    get "/api/v1/merchants/revenue?date=#{Date.today}"

    expect(response).to be_successful
    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data']['attributes']['total_revenue']).to eq('45.0')
  end

  it 'returns the revenue of one merchant' do

    get "/api/v1/merchants/#{@merchant_2.id}/revenue"

    expect(response).to be_successful
    favorite_customer = JSON.parse(response.body)
    expect(favorite_customer['data'].count).to eq(1)
  end

  it 'returns the revenue of one merchant for a selected date' do

    get "/api/v1/merchants/#{@merchant_1.id}/revenue?date=#{2.days.ago}"

    expect(response).to be_successful
    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data']['attributes']['revenue']).to eq('8.0')
  end

  it 'returns the customer who conducted the most transactions with a merchant' do

    get "/api/v1/merchants/#{@merchant_1.id}/favorite_customer"

    expect(response).to be_successful

    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data']['attributes']['id']).to eq(@customer.id)
  end
end

describe 'Boss Mode' do
  it 'returns customers with pending invoices' do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)
    customer_4 = create(:customer)
    customer_5 = create(:customer)

    invoice_1 = create(:invoice, status: 'success', customer_id: customer_1.id)
    invoice_2 = create(:invoice, status: 'pending', customer_id: customer_2.id)
    invoice_3 = create(:invoice, status: 'success', customer_id: customer_3.id)
    invoice_4 = create(:invoice, status: 'pending', customer_id: customer_4.id)
    invoice_5 = create(:invoice, status: 'pending', customer_id: customer_5.id)

    create(:transaction, invoice_id: invoice_1.id)
    create(:transaction, invoice_id: invoice_2.id, result: 'failed')
    create(:transaction, invoice_id: invoice_3.id)
    create(:transaction, invoice_id: invoice_4.id, result: 'failed')
    create(:transaction, invoice_id: invoice_5.id, result: 'failed')

    item = create(:item)

    create(:invoice_item, invoice_id: invoice_1.id, item_id: item.id, quantity: 16, unit_price: 50)
    create(:invoice_item, invoice_id: invoice_2.id, item_id: item.id, quantity: 2, unit_price: 300)
    create(:invoice_item, invoice_id: invoice_3.id, item_id: item.id, quantity: 12, unit_price: 200)
    create(:invoice_item, invoice_id: invoice_4.id, item_id: item.id, quantity: 10, unit_price: 100)
    create(:invoice_item, invoice_id: invoice_5.id, item_id: item.id, quantity: 5, unit_price: 100)

    get "/api/v1/merchants/#{invoice_2.merchant_id}/customers_with_pending_invoices"

    expect(response).to be_successful

    top_merchants = JSON.parse(response.body)
    expect(top_merchants['data'].count).to eq(1)
  end
end
