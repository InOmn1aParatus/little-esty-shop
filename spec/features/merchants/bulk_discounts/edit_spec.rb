require 'rails_helper'

RSpec.describe 'Bulk Discount edit page' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = create(
      :bulk_discount,
      pct_discount: 10,
      qty_threshold: 10,
      merchant_id: @merchant.id
    )

    visit edit_merchant_bulk_discount_path(@merchant, @discount_1)
  end

  it 'contains pre-populated fields' do
    expect(page).to have_field("Percent Discount:", with: "#{@discount_1.pct_discount}")
    expect(page).to have_field("Quantity Threshold:", with: "#{@discount_1.qty_threshold}")
  end

  it 'edits bulk discount information' do
    fill_in "Percent Discount:", with: 15
    click_button "Submit"
    @discount_1.reload

    expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_1))
    expect(@discount_1.pct_discount).to eq(15)
    expect(@discount_1.qty_threshold).to eq(10)
  end
end