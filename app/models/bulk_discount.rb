class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :pct_discount, presence: true, numericality: true
  validates :qty_threshold, presence: true, numericality: true

  # after_save :update_price

  def self.max_discount(qty)
    where("qty_threshold <= ?", qty)
    .order(pct_discount: :desc)
    .limit(1)
    .first
  end

  # def update_price
  #   merchant.items.each do |item|
  #     item.invoice_items do |inv_item|
  #       inv_item.apply_discount
  #     end
  #   end 
  # end

end