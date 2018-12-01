require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Relationships' do
    it { should have_many :invoices }
    it { should have_many(:merchants).through(:invoices)}
  end

  describe 'Validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'Instance Methods' do
    it 'favorite_customer_merchant' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)

      customer = create(:customer)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, status: 'success', created_at: 3.days.ago, updated_at: 2.day.ago)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success', updated_at: Date.today)
      invoice_3 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success', updated_at: Date.today)
      invoice_4 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success', updated_at: Date.today)
      invoice_5 = create(:invoice, merchant_id: merchant_3.id, customer_id: customer.id, status: 'success', updated_at: Date.today)

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)
      create(:transaction, invoice_id: invoice_4.id)
      create(:transaction, invoice_id: invoice_5.id)

      item = create(:item)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: item.id, quantity: 16, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: item.id, quantity: 2, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: item.id, quantity: 12, unit_price: 200)
      create(:invoice_item, invoice_id: invoice_4.id, item_id: item.id, quantity: 10, unit_price: 100)
      create(:invoice_item, invoice_id: invoice_5.id, item_id: item.id, quantity: 5, unit_price: 100)

      expect(customer.favorite_customer_merchant(customer.id)).to eq([merchant_2])
    end
  end
end
