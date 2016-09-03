FactoryGirl.define do
  factory :wei_bungalow do
    wei {Wei.current}
    name {Faker::Hipster.words(2).join(' ')}
    seats {[4,6].sample}
    wei_bus {WeiBus.for_current_wei.to_a.sample}
    gender {%w(M W).sample}
  end
end
