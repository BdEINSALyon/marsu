FactoryGirl.define do
  factory :study_year do
    year {rand(8)+1}
    name {"#{year}A"}
    active {rand(100)<95}
  end
end
