class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item # Test this!
  enum status: [ :pending, :packaged, :shipped ]

  def price_display
    unit_price / 100.00
  end

  def discounted?
    discount = [self.merchant.bulk_discounts.max_discount(self.quantity)]
    discount.size > 0
  end

  def apply_discount
  end
end
