require "test_helper"

class Occurrence::UploadControllerTest < ActionDispatch::IntegrationTest
  test "should get create:post" do
    get occurrence_upload_create:post_url
    assert_response :success
  end

  test "should get destroy:delete" do
    get occurrence_upload_destroy:delete_url
    assert_response :success
  end
end
