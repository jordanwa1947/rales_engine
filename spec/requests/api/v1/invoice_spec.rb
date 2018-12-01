require 'rails_helper'

describe 'Invoice API' do
  it 'sends a list of invoices' do
    create_list(:invoice, 3)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices["data"].count).to eq(3)
  end
end
