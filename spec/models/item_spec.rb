require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Relationships' do
    it { should have_many :invoice_items}
    it { should have_many(:invoices).through(:invoice_items)}
  end

  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :unit_price }
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

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)
      create(:transaction, invoice_id: invoice_4.id)
      create(:transaction, invoice_id: invoice_5.id)
      create(:transaction, invoice_id: invoice_6.id)

      @item_1 = create(:item)
      @item_2 = create(:item)
      @item_3 = create(:item)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: @item_1.id, quantity: 16, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: @item_1.id, quantity: 10, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_4.id, item_id: @item_2.id, quantity: 12, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_5.id, item_id: @item_3.id, quantity: 8, unit_price: 200)
      create(:invoice_item, invoice_id: invoice_6.id, item_id: @item_3.id, quantity: 5, unit_price: 200)
    end

    it 'top_rev_items' do
      expect(Item.top_rev_items(3)).to eq([@item_2, @item_3, @item_1])
    end

    it 'top_quant_items' do
      expect(Item.top_quant_items(3)).to eq([@item_1, @item_2, @item_3])
    end
  end
  describe 'Instance Methods' do
    it 'top_rev_date_for_item' do
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)

      customer = create(:customer)

      invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, status: 'success', updated_at: Date.today)
      invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success', updated_at: Date.today)
      invoice_3 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
      invoice_4 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
      invoice_5 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer.id, status: 'success', created_at: 2.days.ago, updated_at: 1.day.ago)
      invoice_6 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer.id, status: 'success', updated_at: Date.today)

      create(:transaction, invoice_id: invoice_1.id)
      create(:transaction, invoice_id: invoice_2.id)
      create(:transaction, invoice_id: invoice_3.id)
      create(:transaction, invoice_id: invoice_4.id)
      create(:transaction, invoice_id: invoice_5.id)
      create(:transaction, invoice_id: invoice_6.id)

      item_1 = create(:item)
      item_2 = create(:item)
      item_3 = create(:item)

      create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, quantity: 16, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_2.id, item_id: item_1.id, quantity: 10, unit_price: 50)
      create(:invoice_item, invoice_id: invoice_3.id, item_id: item_2.id, quantity: 2, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_4.id, item_id: item_2.id, quantity: 12, unit_price: 300)
      create(:invoice_item, invoice_id: invoice_5.id, item_id: item_3.id, quantity: 8, unit_price: 200)
      create(:invoice_item, invoice_id: invoice_6.id, item_id: item_3.id, quantity: 5, unit_price: 200)

      expect(item_3.top_rev_date_for_item(1.day.ago)).to eq(invoice_5.updated_at)
    end
  end
end
