require 'rails_helper'

RSpec.describe BulkDiscount do
  describe 'relationships' do
    it { should belong_to(:merchant) }  
    it { should validate_presence_of(:pct_discount) }
    it { should validate_numericality_of(:pct_discount) }
    it { should validate_presence_of(:qty_threshold) }
    it { should validate_numericality_of(:qty_threshold) }
  end

  # describe 'instance methods' do
  #   describe '#update_prices' do
  #     it 'updates discount_price of invoice_items upon save' do
  #       merchant = create(:merchant)
  #       item = create(:item, unit_price: 10000, merchant_id: merchant.id)
  #       ii = create(:invoice_item, quantity: 10, unit_price: 10000, item: item)
  #       expect(ii.discount_price).to eq(10000)

  #       bd = create(
  #         :bulk_discount,
  #         merchant_id: merchant.id,
  #         pct_discount: 10,
  #         qty_threshold: 10
  #       )
        
  #       ii.reload
  #       expect(ii.discount_price).to eq(9000)
  #     end
  #   end
  # end
end