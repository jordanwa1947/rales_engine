require 'rails_helper'

describe 'Item Api Requests' do
  it 'sends a list of items' do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
    expect(items["data"].count).to eq(3)
  end

  it 'sends a single item with attribute' do
    merchant = create(:merchant)
    create(:item, name: "skate board")
    create(:item, name: "baseball")
    create(:item, name: "car")

    get '/api/v1/items/find?name=skate board'

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq("skate board")
  end

  it 'sends all items with attribute' do
    merchant = create(:merchant)
    create(:item, name: "skate board")
    create(:item, name: "baseball")
    create(:item, name: "car")
    create(:item, name: "baseball")

    get '/api/v1/items/find_all?name=baseball'

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["data"].count).to eq(2)
  end

  it 'sends one item by id' do
    create(:item, name: "skate board")
    create(:item, name: "baseball")
    item = create(:item, name: "car")
    create(:item, name: "baseball")

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)
    expect(item["data"]["attributes"]["name"]).to eq("car")
  end
end
