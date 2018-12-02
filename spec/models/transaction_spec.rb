require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Relationships' do
    it { should belong_to :invoice }
  end

  describe 'Validations' do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :credit_card_number }
  end

  describe 'Class Methods' do
    before(:each) do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      customer = create(:customer)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, status: 'success')
      invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success')
      invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
      invoice_4 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
      invoice_5 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, status: 'success')
      invoice_6 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success')

      @transaction_1 = create(:transaction, invoice_id: invoice_1.id)
      @transaction_2 = create(:transaction, invoice_id: invoice_2.id)
      @transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "failed")
      @transaction_4 = create(:transaction, invoice_id: invoice_4.id, created_at: 2.days.ago, updated_at: 1.day.ago)
      @transaction_5 = create(:transaction, invoice_id: invoice_5.id, created_at: 2.days.ago, updated_at: 1.day.ago)
      @transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: "failed")

      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 16, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, quantity: 10, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: item_2.id, quantity: 2, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_4.id, item_id: item_2.id, quantity: 12, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_5.id, item_id: item_3.id, quantity: 8, unit_price: 200)
      create(:invoice_item, invoice_id: invoice_6.id, item_id: item_3.id, quantity: 5, unit_price: 200)
    end

    it 'find_by_given_param' do
      transaction = Transaction.find_by_given_param({"credit_card_number"=>"#{@transaction_2["credit_card_number"]}", "controller"=>"api/v1/find_transactions", "action"=>"show"})
      transaction_by_date = Transaction.find_by_given_param({"updated_at"=>1.day.ago, "controller"=>"api/v1/find_transactions", "action"=>"show"})

      expect(transaction["credit_card_number"]).to eq(@transaction_2.credit_card_number)
      expect(transaction["updated_at"]).to eq(@transaction_2.updated_at)
    end

    it 'find_all_by_given_param' do
      transaction = Transaction.find_all_by_given_param({"result"=>"failed", "controller"=>"api/v1/find_transactions", "action"=>"index"})

      expect(transaction).to eq([@transaction_3, @transaction_6])
    end
  end
end
