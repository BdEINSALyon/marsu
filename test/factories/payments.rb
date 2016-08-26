FactoryGirl.define do
  factory :payment do
    payable_type "MyString"
    payable_id 1
    payment_method_id 1
    refunded false
    student_id 1
    user_id 1
    details "MyText"
  end
end
