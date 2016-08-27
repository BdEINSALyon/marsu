FactoryGirl.define do
  factory :membership do
    name {Faker::Commerce.product_name}
    price {Faker::Commerce.price (15..100)}
    start_date {Faker::Date.between(3.months.ago, 6.months.ago)}
    end_date {start_date + (rand(24).to_i.months)}
  end
end
