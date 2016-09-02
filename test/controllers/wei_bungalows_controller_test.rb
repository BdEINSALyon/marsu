require 'test_helper'

class WeiBungalowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @wei_bungalow = wei_bungalows(:one)
  end

  test "should get index" do
    get wei_bungalows_url
    assert_response :success
  end

  test "should get new" do
    get new_wei_bungalow_url
    assert_response :success
  end

  test "should create wei_bungalow" do
    assert_difference('WeiBungalow.count') do
      post wei_bungalows_url, params: { wei_bungalow: {  } }
    end

    assert_redirected_to wei_bungalow_url(WeiBungalow.last)
  end

  test "should show wei_bungalow" do
    get wei_bungalow_url(@wei_bungalow)
    assert_response :success
  end

  test "should get edit" do
    get edit_wei_bungalow_url(@wei_bungalow)
    assert_response :success
  end

  test "should update wei_bungalow" do
    patch wei_bungalow_url(@wei_bungalow), params: { wei_bungalow: {  } }
    assert_redirected_to wei_bungalow_url(@wei_bungalow)
  end

  test "should destroy wei_bungalow" do
    assert_difference('WeiBungalow.count', -1) do
      delete wei_bungalow_url(@wei_bungalow)
    end

    assert_redirected_to wei_bungalows_url
  end
end
