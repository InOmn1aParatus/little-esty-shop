FactoryBot.define do
  factory :bulk_discount do
    pct_discount { Faker::Number.between(from: 1, to: 50) }
    qty_threshold { Faker::Number.between(from: 1, to: 20) }
  end
end
