require 'test_helper'

module Api::V1
  class PlansControllerTest < ActionDispatch::IntegrationTest
    
    test "should get index" do
      get api_v1_plans_path, as: :json
      assert_response :success
    end

    test "should get show" do
      plan = plans(:one)
      get api_v1_plan_path(id: plan.oid), as: :json
      assert_response :success
    end

    test "should not find a plan for wrong oid" do
      plan = plans(:one)
      get api_v1_plan_path(id: plan.id), as: :json
      assert_response :not_found
    end

    test "should create a plan" do
      assert_difference('Plan.count') do
        post api_v1_plans_url, 
          params: { name: 'Three Name', oid: 'three', interval: 'yearly', interval_count: 2, amount: 99.99, currency: 'USD', platform: 'stripe' },
          as: :json
      end
    end

    test "should not create a plan for incorrect data" do
      assert_difference('Plan.count', 0) do
        post api_v1_plans_url, 
          params: { name: 'Three Name', oid: plans(:one).oid, interval: 'yearly', interval_count: 2, amount: 99.99, currency: 'USD', platform: 'stripe' },
          as: :json
      end
    end

    test "should update a plan" do
      plan = plans(:one)
      put api_v1_plan_url(id: plan.oid), params: { name: 'New Two Name' }, as: :json
      plan.reload
      assert_equal "New Two Name", plan.name
    end

    test "should not update a plan for incorrect data" do
      plan = plans(:one)
      
      put api_v1_plan_url(id: plan.oid), params: { oid: plans(:two).oid}, as: :json
      plan.reload
      assert_response :unprocessable_entity

      put api_v1_plan_url(id: "not_valid_id"), params: { name: 'New One Name' }, as: :json
      plan.reload
      assert_response :not_found
    end    

  end
end