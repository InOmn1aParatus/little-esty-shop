class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    response = Faraday.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed = JSON.parse(response.body, symbolize_names: true)
    @holidays = []
    parsed[0..2].each do |holiday|
      @holidays << Holiday.new(holiday[:name], holiday[:date])
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(bulk_dicsount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def update
    require 'pry'; binding.pry
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.destroy(params[:id])
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:id])
    discount.update(bulk_dicsount_params)
    redirect_to merchant_bulk_discount_path(merchant, discount)
  end

private
  def bulk_dicsount_params
    params.require(:bulk_discount).permit(:pct_discount, :qty_threshold)
  end

end