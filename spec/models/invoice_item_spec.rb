require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do

  describe 'relationships' do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_one(:merchant).through(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe 'instance methods' do
    describe '#price_display' do
      it 'displays unit_price in dollar amount' do
        invoice = create(:invoice)
        item = create(:item)
        invoice_item = InvoiceItem.create!(
          invoice: invoice,
          item: item,
          quantity: 1,
          unit_price: 11111,
          status: 0
        )
        expect(invoice_item.price_display).to eq(111.11)
      end
    end

    describe '#discounted?' do
      it 'determines if invoice item is discounted' do
        ii = create(:invoice_item, quantity: 10)
        bd = create(:bulk_discount, merchant_id: ii.merchant.id, qty_threshold: 10)
        expect(ii.discounted?).to eq(true)
      end
    end
  end
end
