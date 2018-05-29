require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get plans_path
    assert_response :success
  end

  test "should get show" do
    plan = plans(:one)
    get plan_path(plan)
    assert_response :success
  end

end
