require 'test_helper'

class RegistrationControllerTest < ActionDispatch::IntegrationTest
  test "should get start" do
    get registration_start_url
    assert_response :success
  end

  test "should get register" do
    get registration_register_url
    assert_response :success
  end

  test "should get questions" do
    get registration_questions_url
    assert_response :success
  end

  test "should get pay" do
    get registration_pay_url
    assert_response :success
  end

  test "should get card" do
    get registration_card_url
    assert_response :success
  end

  test "should get details" do
    get registration_details_url
    assert_response :success
  end

end
