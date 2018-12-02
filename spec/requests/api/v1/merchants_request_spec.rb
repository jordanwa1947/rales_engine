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
end
