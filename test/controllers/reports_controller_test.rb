require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should be able to get index" do
    get reports_path
    assert_response :success
  end
end
