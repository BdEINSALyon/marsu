FactoryGirl.define do
  factory :student do
    gender {rand(100)>40?'M':'W'}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    sequence(:email)  {|n|"#{first_name.downcase}.#{last_name.downcase}.#{n}@insa-lyon.fr"}
    student_id {rand(10000000)}
    phone {Faker::PhoneNumber.cell_phone}
    birthday {Faker::Date.between(16.years.ago, 26.years.ago)}
    details {Faker::Hipster.sentences(0,5)}

    trait :is_member do
      after(:create) do |student|
        student.payments.create payable: Membership.active.to_a.sample, payment_method: PaymentMethod.enabled.last
      end
    end

    trait :with_department do
      department {Department.active.to_a.sample}
    end

    trait :with_study_year do
      study_year {StudyYear.all.to_a.sample}
    end
  end
end
