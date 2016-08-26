require 'test_helper'

class DepartmentTest < ActiveSupport::TestCase
  test "should be unique by code" do
    FactoryGirl.create(:departement, code: 'TEST')
    assert_not FactoryGirl.build(:departement, code: 'TEST').save
    Department.find_by_code('TEST').delete
  end
  test 'should have a name and code' do
    assert_not Department.new.save
    assert Department.new(code: 'JKJKJSD', name:'MyTest').save
  end
end
