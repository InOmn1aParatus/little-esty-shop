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
    !bulk_discount.nil?
  end

  def bulk_discount
    merchant
    .bulk_discounts
    .max_discount(self.quantity)
  end
end
