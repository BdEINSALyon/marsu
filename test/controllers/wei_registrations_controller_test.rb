require 'test_helper'

class WeiRegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wei_registration = wei_registrations(:one)
  end

  test "should get index" do
    get wei_registrations_url
    assert_response :success
  end

  test "should get new" do
    get new_wei_registration_url
    assert_response :success
  end

  test "should create wei_registration" do
    assert_difference('WeiRegistration.count') do
      post wei_registrations_url, params: { wei_registration: {  } }
    end

    assert_redirected_to wei_registration_url(WeiRegistration.last)
  end

  test "should show wei_registration" do
    get wei_registration_url(@wei_registration)
    assert_response :success
  end

  test "should get edit" do
    get edit_wei_registration_url(@wei_registration)
    assert_response :success
  end

  test "should update wei_registration" do
    patch wei_registration_url(@wei_registration), params: { wei_registration: {  } }
    assert_redirected_to wei_registration_url(@wei_registration)
  end

  test "should destroy wei_registration" do
    assert_difference('WeiRegistration.count', -1) do
      delete wei_registration_url(@wei_registration)
    end

    assert_redirected_to wei_registrations_url
  end
end
