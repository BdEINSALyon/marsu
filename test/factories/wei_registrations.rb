FactoryGirl.define do
  factory :wei_registration do
    wei {Wei.current}
    student {Student.where.not(id: wei.students).to_a.sample}
    registration_by {Faker::Time.between 15.days.ago, 2.days.since}
    status "waiting"
    paid {false}

    trait :registered do
      status "registered"
      paid true
      before(:create) do |reg|
        Payment.create student: reg.student, payable: reg.wei, payment_method: PaymentMethod.all.to_a.sample
      end
    end

    trait :with_bus do
      wei_bungalow {WeiBungalow.not_full.to_a.sample}
      wei_bus {wei_bungalow.wei_bus}
    end

    trait :canceled do
      status "canceled"
    end
  end
end
