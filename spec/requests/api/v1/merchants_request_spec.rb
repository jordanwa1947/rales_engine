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

  it 'sends all merchants with attribute' do
    create(:merchant, name: 'Mcdonalds')
    create(:merchant, name: 'Turing')
    create(:merchant, name: 'Best Buy')
    create(:merchant, name: 'Turing')

    get '/api/v1/merchants/find_all?name=Turing'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(2)
  end

  it 'sends a random merchant' do
    create(:merchant, name: 'Mcdonalds')
    create(:merchant, name: 'Turing')
    create(:merchant, name: 'Best Buy')
    create(:merchant, name: 'Turing')

    get '/api/v1/merchants/random.json'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].count).to eq(1)
  end

  it 'sends one merchant found by id' do
    create(:merchant, name: 'Mcdonalds')
    create(:merchant, name: 'Turing')
    create(:merchant, name: 'Best Buy')
    merchant = create(:merchant, name: 'Turing')

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"]["attributes"]["name"]).to eq("Turing")
  end
end
