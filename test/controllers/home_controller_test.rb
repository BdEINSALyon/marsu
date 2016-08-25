require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test 'should index be homepage' do
    get '/'
    assert_response :success
  end

end
