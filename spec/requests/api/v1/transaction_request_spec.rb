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

    get "/api/v1/transactions/find?credit_card_number=#{Transaction.second.credit_card_number}"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)
    credit_card_number = transactions["data"]["attributes"]["credit_card_number"]

    expect(credit_card_number).to eq(Transaction.second.credit_card_number)
  end

  it 'loads all instances with specified attribute' do
    merchant_1 = create(:merchant)

    customer = create(:customer)

    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_2 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id)
    invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, created_at: 2.days.ago, updated_at: 1.day.ago)

    @transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: 'failed')
    @transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    @transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: 'failed')

    get "/api/v1/transactions/find_all?result=failed"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(2)
  end
end
