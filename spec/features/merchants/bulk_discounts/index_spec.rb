require 'rails_helper'

RSpec.describe 'Bulk Discounts ' do
  before :each do
    @merchant = create(:merchant)
    @discount_1 = create(:bulk_discount, merchant_id: @merchant.id)
    @discount_2 = create(:bulk_discount, merchant_id: @merchant.id)
    @holiday_1 = Holiday.new("Pie Day", "1-01-2021")
    @holiday_2 = Holiday.new("Cake Day", "1-02-2021")
    @holiday_3 = Holiday.new("Ambiguous Pastry Day", "1-03-2021")

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
  end
end