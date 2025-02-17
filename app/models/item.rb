class Item < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  belongs_to :merchant
  has_many :invoice_items, :dependent => :destroy
  has_many :invoices, through: :invoice_items

  def self.ready_to_ship
    joins(invoices: :transactions)
    .select('items.*, invoices.created_at as inv_created_at, invoices.id as invoice_id')
    .where("transactions.result = ?", 'success')
    .where.not("invoice_items.status = ?", 2)
    .distinct
    .order('invoices.created_at')
  end

  def self.popular_items
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price/100.0) as revenue')
    .joins(invoices: :transactions)
    .where("transactions.result = 'success'")
    .group('items.id')
    .order('revenue DESC')
    .limit(5)
  end

  def self.item_top_day(item_id)
    select('invoices.created_at, sum(invoice_items.quantity * invoice_items.unit_price/100.0) as revenue')
    .joins(invoices: :transactions)
    .where("transactions.result = 'success'")
    .group('invoices.created_at')
    .order('revenue DESC', 'invoices.created_at DESC')
    .find(item_id).created_at
  end

  def unit_price_dollars
    unit_price / 100.0
  end
end
