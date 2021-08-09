FactoryBot.define do
  factory :merchant do
    name { Faker::Company.name }
    status { "disabled" }
  end
end
