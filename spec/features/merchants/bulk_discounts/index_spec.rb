require 'rails_helper'

RSpec.describe 'Bulk Discounts ' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = create(:bulk_discount, merchant_id: @merchant.id)
    @discount_2 = create(:bulk_discount, merchant_id: @merchant.id)

    visit merchant_bulk_discounts_path(@merchant)
  end
  
  it 'displays all bulk discounts including their attributes' do

    expect(page).to have_content(@discount_1.pct_discount)
    expect(page).to have_content(@discount_1.qty_threshold)
    expect(page).to have_content(@discount_2.pct_discount)
    expect(page).to have_content(@discount_2.qty_threshold)
  end

  it 'links to discount show page through id' do
    click_link "#{@discount_1.id}"
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @discount_1))
  end

  it 'lists the next 3 upcoming holidays using API' do
    expect(page).to have_content("Upcoming Holidays")
    # Test for presence of 3 holidays
  end

  it 'displays link to create a new discount' do
    click_link "Create New Discount"

    expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant))
    expect(page).to have_field("Percent Discount:")
    expect(page).to have_field("Quantity Threshold:")
  end

  it 'can delete discounts from page' do
    within("#discounts") do
      click_link('Delete Discount', match: :first)
    end
    
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))
    expect(page).to have_content(@discount_2.id)
    expect(page).to_not have_content(@discount_1.id)
  end
end