 require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'Relationships' do
    it { should belong_to :invoice}
    it { should belong_to :item }
  end

  describe 'Validations' do
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :invoice_id }
  end
end
