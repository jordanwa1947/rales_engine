require 'rails_helper'

describe 'Invoice API' do
  it 'sends a list of invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end

  it 'send a single item with attribute' do
    create(:invoice, status: 'shipped')
    create(:invoice, status: 'pending')
    create(:invoice, status: 'shipped')

    get '/api/v1/invoices/find?status=pending'

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice["data"]["attributes"]["status"]).to eq("pending")
  end

  it 'send all items with attribute' do
    create(:invoice, status: 'shipped')
    create(:invoice, status: 'pending')
    create(:invoice, status: 'shipped')

    get '/api/v1/invoices/find_all?status=shipped'

    expect(response).to be_successful

    invoice = JSON.parse(response.body)
    expect(invoice["data"].count).to eq(2)
  end
end
