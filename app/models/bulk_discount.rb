class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :pct_discount, presence: true, numericality: true
  validates :qty_threshold, presence: true, numericality: true

  def self.max_discount(qty)
    where("qty_threshold <= ?", qty)
    .order(pct_discount: :desc)
    .limit(1)
    .first
  end

end