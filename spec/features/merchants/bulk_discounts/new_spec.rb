require 'rails_helper'

RSpec.describe 'new Bulk Discount page' do
  before :each do
    @merchant = create(:merchant)
    visit new_merchant_bulk_discount_path(@merchant)
  end

  it 'creates a new bulk discount using form' do
    fill_in "Percent Discount:", with: 10
    fill_in "Quantity Threshold:", with: 10

    click_button "Submit"
    expect(current_path).to eq(merchant_bulk_discounts_path(@merchant))

    within("#discounts") do
      expect(page).to have_content("10")
    end
  end
end