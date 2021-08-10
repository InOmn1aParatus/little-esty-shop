require 'rails_helper'

RSpec.describe 'Merchant Invoices show page' do
  before :each do
    @merchant = create(:merchant)
    @bulk_discount = BulkDiscount.create(merchant_id: @merchant.id, pct_discount: 10, qty_threshold: 10)

    @customer = create(:customer)

    @invoice = create(:invoice, customer_id: @customer.id)

    @item_1 = create(:item, merchant_id: @merchant.id)
    @item_2 = create(:item, merchant_id: @merchant.id)

    @invoice_item_1 = create(:invoice_item, quantity: 10, item_id: @item_1.id, invoice_id: @invoice.id, status: 1)
    @invoice_item_2 = create(:invoice_item, quantity: 1, item_id: @item_2.id, invoice_id: @invoice.id, status: 1)

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  it 'can see all of that merchants invoice info' do
    expect(page).to have_content("Invoice ##{@invoice.id}")
    expect(page).to have_content("Status: #{@invoice.status}")
    expect(page).to have_content("Created On: #{@invoice.created_at.strftime('%A, %B %d, %Y')}")
    expect(page).to have_content(@customer.first_name)
    expect(page).to have_content(@customer.last_name)
  end

  it "displays the invoice item information such as the item name, quantity ordered, price of item, invoice item status" do
    within "#invoice_item-info-#{@invoice_item_1.id}" do
      expect(page).to have_content("Invoice item name: #{@item_1.name}")
      expect(page).to have_content("Invoice item quantity: #{@invoice_item_1.quantity}")
      expect(page).to have_content("Invoice item price: #{@invoice_item_1.unit_price}")
      expect(page).to have_content("Invoice item status: #{@invoice_item_1.status}")
    end

    within "#invoice_item-info-#{@invoice_item_2.id}" do
      expect(page).to have_content("Invoice item name: #{@item_2.name}")
      expect(page).to have_content("Invoice item quantity: #{@invoice_item_2.quantity}")
      expect(page).to have_content("Invoice item price: #{@invoice_item_2.unit_price}")
      expect(page).to have_content("Invoice item status: #{@invoice_item_2.status}")
    end
  end

  it "displays the total revenue from all items on the invoice" do
    expect(page).to have_content("Total revenue from invoice: $#{@invoice.total_revenue}")
  end

  it 'can click on the select status for an item and update it to a new status' do
    within "#invoice_item-info-#{@invoice_item_1.id}" do

     expect(page).to have_content("Invoice item status: #{@invoice_item_1.status}")

     expect(page).to have_select(:status, selected: 'packaged')
     expect(page).to have_select(:status, :options => ['pending', 'packaged', 'shipped'])

     select('shipped', from: 'status')

     click_on('Update Item Status')

     expect(current_path).to eq("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")

     expect(page).to have_select(:status, selected: 'shipped')
   end
  end

  it 'displays total revenue with & without discounts' do
    expect(page).to have_content("Total revenue from invoice: $#{@invoice.total_revenue}")
    expect(page).to have_content("Discounted revenue from invoice: $#{@invoice.discounted_revenue}")
    save_and_open_page
  end
  # When I visit my merchant invoice show page
  # Then I see the total revenue for my merchant from this invoice
  # (not including discounts)
  # And I see the total discounted revenue for my merchant
  # from this invoice which includes bulk discounts in the calculation

  it 'links to bulk_discount show page if discount was applied' do
    click_link "View Discount"
    expect(current_path).to eq(merchant_bulk_discount_path(@merchant, @invoice_item_1.bulk_discount))
  end
end
