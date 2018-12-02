require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(3)
  end

  it 'sends a single merchant with attribute' do
    create(:merchant, name: 'Mcdonalds')
    create(:merchant, name: 'Best Buy')
    create(:merchant, name: 'Turing')

    get '/api/v1/merchants/find?name=Best Buy'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"]["attributes"]["name"]).to eq("Best Buy")
  end

  it 'sends all merchant with attribute' do
    create(:merchant, name: 'Mcdonalds')
    create(:merchant, name: 'Turing')
    create(:merchant, name: 'Best Buy')
    create(:merchant, name: 'Turing')

    get '/api/v1/merchants/find_all?name=Turing'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
  end

  describe 'Association Api Requests' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)

      customer = create(:customer)

      invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success')
      invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success')
      invoice_3 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
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
      @item_4 = create(:item)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: @item_1.id, quantity: 16, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: @item_2.id, quantity: 10, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_4.id, item_id: @item_4.id, quantity: 12, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_5.id, item_id: @item_3.id, quantity: 8, unit_price: 200)
      create(:invoice_item, invoice_id: invoice_6.id, item_id: @item_2.id, quantity: 5, unit_price: 200)
    end

    it 'sends all items associated with a merchant' do
      get "/api/v1/merchants/#{@merchant_2.id}/items"

      expect(response).to be_successful

      merchant_items = JSON.parse(response.body)
      items_array = merchant_items["data"].count
      expect(items_array).to eq(2)
    end
  end
end
