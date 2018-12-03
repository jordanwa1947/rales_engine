require 'rails_helper'

describe 'Invoice Item Requests' do
  it 'sends a list of invoice items' do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)
    expect(invoice_items["data"].count).to eq(3)
  end

  it 'returns a sing invoice_item with attribute' do
    create(:invoice_item, quantity: 3)
    create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 1)

    get '/api/v1/invoice_items/find?quantity=5'

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["quantity"]).to eq(5)
  end

  it 'returns all invoice_items with attribute' do
    create(:invoice_item, quantity: 3)
    create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 1)
    create(:invoice_item, quantity: 5)

    get '/api/v1/invoice_items/find_all?quantity=5'

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["data"].count).to eq(3)
  end

  it 'returns all invoice_items with attribute' do
    create(:invoice_item, quantity: 3)
    new_invoice_item = create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 5)
    create(:invoice_item, quantity: 1)
    create(:invoice_item, quantity: 5)

    get "/api/v1/invoice_items/#{new_invoice_item.id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)
    expect(invoice_item["data"]["attributes"]["id"]).to eq(new_invoice_item.id)
  end
end
