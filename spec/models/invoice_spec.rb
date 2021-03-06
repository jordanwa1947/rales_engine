 require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Relationships' do
    it { should have_many :transactions }
    it { should have_many :invoice_items}
    it { should have_many(:items).through(:invoice_items)}
  end

  describe 'Validations' do
    it { should validate_presence_of :status }
    it { should validate_presence_of :merchant_id }
    it { should validate_presence_of :customer_id }
  end
end
