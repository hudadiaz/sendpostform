require 'test_helper'

class ConfirmationControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get confirm_create_url
    assert_response :success
  end

end
