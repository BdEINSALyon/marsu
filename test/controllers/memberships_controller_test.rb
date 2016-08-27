require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get memberships_create_url
    assert_response :success
  end

  test "should get update" do
    get memberships_update_url
    assert_response :success
  end

  test "should get index" do
    get memberships_index_url
    assert_response :success
  end

end
