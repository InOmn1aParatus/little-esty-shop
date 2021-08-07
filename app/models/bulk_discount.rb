class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  validates :pct_discount, presence: true, numericality: true
  validates :qty_threshold, presence: true, numericality: true
end