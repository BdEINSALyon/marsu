FactoryGirl.define do
  factory :wei_bus do
    wei {Wei.current}
    name {Faker::Hipster.word}
    seats {40+rand(15)}
  end
end
