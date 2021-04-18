require "test_helper"

class TextStatusControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get text_status_show_url
    assert_response :success
  end
end
