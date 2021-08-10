require 'rails_helper'

RSpec.describe 'Admin Invoice show page' do
  before :each do
    @merchant = create(:merchant)
    @discount = create(:bulk_discount, qty_threshold: 5, pct_discount: 10, merchant_id: @merchant.id)
    @invoice_1 = create(:invoice, status: 'in progress')
    @item_1 = create(:item, merchant_id: @merchant.id)
    @invoice_item_1 = InvoiceItem.create!(
      invoice: @invoice_1,
      item: @item_1,
      quantity: 10,
      status: 0,
      unit_price: 10000
    )

    visit admin_invoice_path(@invoice_1)
  end

  it 'shows information regarding the invoice' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.created_at_display)
    expect(page).to have_content(@invoice_1.customer.first_name)
    expect(page).to have_content(@invoice_1.customer.last_name)
  end

  it 'shows invoice items and item information' do
    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.price_display)
    expect(page).to have_content(@invoice_item_1.status)
  end

  it 'shows total revenue to be earned through invoice' do
    expect(page).to have_content("Total Projected Revenue: $#{@invoice_1.total_revenue}")
  end

  it 'displays select field with current invoice status selected' do
    expect(page).to have_content('Status:')
    expect(page).to have_select(selected: "#{@invoice_1.status.titleize}")
  end

  it 'can update status using select field' do
    expect(@invoice_1.status).to eq('in progress')
    select('Completed')
    
    click_button 'Update Invoice'
    @invoice_1.reload

    expect(@invoice_1.status).to eq('completed')
  end

  it 'displays both total revenue and revenue after discount' do
    expect(page).to have_content("Total Projected Revenue: $#{@invoice_1.total_revenue}")
    expect(page).to have_content("Revenue after discounts: $#{@invoice_1.discounted_revenue}")
  end
end