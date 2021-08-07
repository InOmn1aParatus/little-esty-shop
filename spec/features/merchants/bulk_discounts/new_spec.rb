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
    save_and_open_page
  end
  # Then I am taken to a new page where I see a form to add a new bulk discount
  # When I fill in the form with valid data
  # Then I am redirected back to the bulk discount index
  # And I see my new bulk discount listed
end