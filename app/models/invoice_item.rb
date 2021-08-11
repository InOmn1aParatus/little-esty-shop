class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  enum status: [ :pending, :packaged, :shipped ]

  after_save :apply_discount

  def price_display
    unit_price / 100.00
  end
  
  def discount_display
    discount_price / 100.00
  end

  def discounted?
    !bulk_discount.nil?
  end

  def bulk_discount
    merchant
    .bulk_discounts
    .max_discount(self.quantity)
  end

  def apply_discount
    if self.discounted?
      update_columns(discount_price: unit_price * (1 - bulk_discount.pct_discount / 100.00 ))
    else
      update_columns(discount_price: unit_price)
    end
  end
end
