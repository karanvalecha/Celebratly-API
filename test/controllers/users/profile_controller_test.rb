require "test_helper"

class Users::ProfileControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_profile_show_url
    assert_response :success
  end

  test "should get update" do
    get users_profile_update_url
    assert_response :success
  end
end
