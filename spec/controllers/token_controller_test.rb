require 'test_helper'

class TokenControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get token_create_url
    assert_response :success
  end

end
