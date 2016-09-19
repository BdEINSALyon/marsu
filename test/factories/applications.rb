FactoryGirl.define do
  factory :application do
    name {Faker::App.name}
    type {%w(full-access limited restrictive).sample}
    secret 'secret-is-not-secret'
  end
end
