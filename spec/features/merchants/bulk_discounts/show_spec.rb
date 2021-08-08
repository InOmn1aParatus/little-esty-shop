require 'rails_helper'

RSpec.describe 'Bulk Discount show page' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = create(:bulk_discount, merchant_id: @merchant.id)

    visit merchant_bulk_discount_path(@merchant, @discount_1)
  end

  it 'displays basic discount information' do
    expect(page).to have_content(@discount_1.id)
    expect(page).to have_content(@discount_1.pct_discount)
    expect(page).to have_content(@discount_1.qty_threshold)
  end

  it 'displays link to edit discount' do
    click_link "Edit Discount"
    expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant, @discount_1))
  end
end