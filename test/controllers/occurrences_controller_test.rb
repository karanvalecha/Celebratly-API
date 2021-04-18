require "test_helper"

class OccurrencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @occurrence = occurrences(:one)
  end

  test "should get index" do
    get occurrences_url, as: :json
    assert_response :success
  end

  test "should create occurrence" do
    assert_difference('Occurrence.count') do
      post occurrences_url, params: { occurrence: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show occurrence" do
    get occurrence_url(@occurrence), as: :json
    assert_response :success
  end

  test "should update occurrence" do
    patch occurrence_url(@occurrence), params: { occurrence: {  } }, as: :json
    assert_response 200
  end

  test "should destroy occurrence" do
    assert_difference('Occurrence.count', -1) do
      delete occurrence_url(@occurrence), as: :json
    end

    assert_response 204
  end
end
