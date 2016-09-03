FactoryGirl.define do
  factory :wei do
    name {Faker::Commerce.product_name}
    enabled true
    price {rand 50}
    seats {450 + rand(50)}
    date {Faker::Date.forward 25}
  end
end
