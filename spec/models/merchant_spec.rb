require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Relationships' do
    it { should have_many :invoices}
    it { should have_many(:customers).through(:invoices)}
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
  end

  describe 'Class Methods' do
    before(:each) do
      @merchant_1 = create(:merchant)
      @merchant_2 = create(:merchant)
      @merchant_3 = create(:merchant)

      customer = create(:customer)

      invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success', created_at: 2.day.ago, updated_at: 1.day.ago)
      invoice_2 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success')
      invoice_3 = create(:invoice, merchant_id: @merchant_2.id, customer_id: customer.id, status: 'success')
      invoice_4 = create(:invoice, merchant_id: @merchant_3.id, customer_id: customer.id, status: 'success')
      invoice_5 = create(:invoice, merchant_id: @merchant_3.id, customer_id: customer.id, status: 'success')

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
    end

    it 'top_merch_by_rev' do
      expect(Merchant.top_merch_by_rev(3)).to eq([@merchant_2, @merchant_3, @merchant_1])
    end

    it 'top_merch_by_quantity' do
      expect(Merchant.top_merch_by_quantity(3)).to eq([@merchant_1, @merchant_3, @merchant_2])
    end

    it 'total_rev_by_date' do
      expect(Merchant.total_rev_by_date(Date.today)).to eq(4500)
    end
  end

  describe 'Instance Methods' do
    before(:each) do
      @merchant_1 = create(:merchant)

      customer = create(:customer)
      customer_2 = create(:customer)

      invoice_1 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer.id, status: 'success', created_at: 2.day.ago, updated_at: 1.day.ago)
      invoice_2 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer_2.id, status: 'success')
      invoice_3 = create(:invoice, merchant_id: @merchant_1.id, customer_id: customer_2.id, status: 'success')

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)

      item = create(:item)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: item.id, quantity: 16, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: item.id, quantity: 2, unit_price: 300, created_at: 2.days.ago, updated_at: 1.day.ago)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: item.id, quantity: 12, unit_price: 200)
    end

    it 'total_single_merch_rev' do

    end
  end
end
