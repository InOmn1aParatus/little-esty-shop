FactoryBot.define do
  factory :bulk_discount do
    pct_discount { [10, 20, 30, 40, 50].sample }
    qty_threshold { Faker::Number.between(from: 1, to: 20) }
  end
end
