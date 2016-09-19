FactoryGirl.define do
  factory :application_token do
    application_id 1
    token "MyString"
    expiration "2016-09-19 22:26:26"
  end
end
