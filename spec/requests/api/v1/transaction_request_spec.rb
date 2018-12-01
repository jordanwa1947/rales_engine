require 'rails_helper'

describe 'Transaction Api Requests' do
  it 'loads an index of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(3)
  end
end
