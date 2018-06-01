require 'test_helper'

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subscriptions_url
    assert_response :success
  end

  test "should create a subscription" do
    random_oid = SecureRandom.hex
    assert_difference('Subscription.count') do
      post subscriptions_url, params: { subscription: { oid: random_oid, plan_id: plans(:one).id, customer_id: customers(:one).id, active: true, started_at: Time.now, quantity: 1 } }
    end

    assert_response :success

    subscription = Subscription.last
    assert_equal random_oid, subscription.oid
  end

  test "should update a subscription" do
    subscription = subscriptions(:one)
    active = false
    quantity = 2
    
    assert_not_equal active, subscription.active
    assert_not_equal quantity, subscription.quantity
    
    patch subscription_path(subscription), params: { subscription: { active: false, quantity: 2 } }

    assert_response :success

    subscription.reload

    assert_equal active, subscription.active
    assert_equal quantity, subscription.quantity
  end
end
