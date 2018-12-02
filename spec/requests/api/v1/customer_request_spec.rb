require 'rails_helper'

describe 'Customers API' do
  it 'sends a list of customers' do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(3)
  end

  it 'sends a single customer based on attribute' do
    customer_1 = create(:customer, first_name: "Jordan")
    customer_2 = create(:customer, first_name: "James")
    customer_3 = create(:customer)

    get '/api/v1/customers/find?first_name=James'

    expect(response).to be_successful

    customer = JSON.parse(response.body)
    expect(customer["data"]["attributes"]["first_name"]).to eq("James")
  end

  it 'sends all customers with an attribute' do
    create(:customer, first_name: "James")
    create(:customer, first_name: "James")
    create(:customer)

    get '/api/v1/customers/find_all?first_name=James'

    expect(response).to be_successful

    customers = JSON.parse(response.body)
    expect(customers["data"].count).to eq(2)
  end
end
