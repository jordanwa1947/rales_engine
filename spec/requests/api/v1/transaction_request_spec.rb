require 'rails_helper'

describe 'Transaction Api Requests' do
  it 'loads an index of transactions' do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"].count).to eq(3)
  end

  it 'loads a specified instance of transaction' do
    create_list(:transaction, 3)

    get '/api/v1/transactions/find?credit_card_number = 2'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    expect(transactions["data"]["credit_card_number"]).to eq(2)
  end
end