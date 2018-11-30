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

    end

    it 'top_rev_items' do

    end 
  end
end
