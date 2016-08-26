FactoryGirl.define do
  factory :department do
    name {Faker::Educator.course}
    code do
      code = (0...2).map { ('A'..'Z').to_a[rand(26)] }.join
      until Department.find_by_code(code).nil?
        code = (0...2).map { ('A'..'Z').to_a[rand(26)] }.join
      end
      code
    end
    active {rand(100)<98}
  end
end
