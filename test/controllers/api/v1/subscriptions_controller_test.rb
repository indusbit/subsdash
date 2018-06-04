require 'test_helper'

class Api::V1::SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  FIELDS = [:oid, :quantity, :started_at] # cancelled_at not included as it might be nil at times.

  def body
    @body ||= JSON @response.body
  end

  setup do
    @headers = {}
    @headers['Accept'] = Mime[:json].to_s
    @headers['Content-Type'] = Mime[:json].to_s    
  end

  test 'should fetch all subscriptions' do
    get api_v1_subscriptions_path, headers: @headers
    assert_response :success

    assert_instance_of Array, body['subscriptions']
    assert_equal Subscription.count, body['subscriptions'].count

    body['subscriptions'].each do |subscription|
      FIELDS.each do |field|
        assert_not_nil subscription[field.to_s]
      end

      assert_not_nil subscription['plan']
      assert_not_nil subscription['customer']
    end
  end

  test 'should fetch a specific subscription' do
    subscription = subscriptions :one
    get api_v1_subscription_path(id: subscription.oid), headers: @headers
    assert_response :success

    assert_instance_of Hash, body['subscription']

    FIELDS.each do |field|
      assert_equal subscription[field], body['subscription'][field.to_s]
    end

    assert_not_nil body['subscription']['plan']
    assert_not_nil body['subscription']['customer']
  end

  test 'should throw not found if subscription not found' do
    oid = 'NotInDatabase'
    assert_empty Subscription.where(oid: oid)

    # for subscriptions#show
    get api_v1_subscription_path(id: oid), headers: @headers

    assert_response :not_found

    # for subscriptions#update
    patch api_v1_subscription_path(id: oid), headers: @headers

    assert_response :not_found
  end

  test 'should create a subscription without a cancelled_at' do
    subscription = {}
    subscription[:oid] = SecureRandom.hex
    subscription[:quantity] = 1
    subscription[:started_at] = 10.seconds.ago
    subscription[:plan_id] = plans(:one).oid
    subscription[:customer_id] = customers(:one).oid

    assert_difference('Subscription.count') do
      post api_v1_subscriptions_path, params: subscription, headers: @headers, as: :json
    end

    assert_response :success

    new_subscription = Subscription.last

    FIELDS.each do |field|
      next if field == :started_at
      assert_equal subscription[field], body['subscription'][field.to_s]
      assert_equal subscription[field], new_subscription[field]
    end

    assert_in_delta subscription[:started_at], body['subscription'][:started_at.to_s].to_datetime, 1.second
    assert_in_delta subscription[:started_at], new_subscription[:started_at], 1.second

    assert_nil new_subscription.cancelled_at

    assert_equal subscription[:plan_id], new_subscription.plan.oid
    assert_equal subscription[:customer_id], new_subscription.customer.oid
  end

  test 'should create a subscription with a cancelled_at' do
    subscription = {}
    subscription[:oid] = SecureRandom.hex
    subscription[:quantity] = 1
    subscription[:started_at] = 10.months.ago
    subscription[:cancelled_at] = 10.seconds.ago
    subscription[:plan_id] = plans(:one).oid
    subscription[:customer_id] = customers(:one).oid

    assert_difference('Subscription.count') do
      post api_v1_subscriptions_path, params: subscription, headers: @headers, as: :json
    end

    assert_response :success

    new_subscription = Subscription.last

    FIELDS.each do |field|
      next if field == :started_at
      assert_equal subscription[field], body['subscription'][field.to_s]
      assert_equal subscription[field], new_subscription[field]
    end

    assert_in_delta subscription[:started_at], body['subscription'][:started_at.to_s].to_datetime, 1.second
    assert_in_delta subscription[:started_at], new_subscription[:started_at], 1.second

    assert_not_nil new_subscription.cancelled_at

    assert_in_delta subscription[:cancelled_at], body['subscription'][:cancelled_at.to_s].to_datetime, 1.second
    assert_in_delta subscription[:cancelled_at], new_subscription[:cancelled_at], 1.second

    assert_equal subscription[:plan_id], new_subscription.plan.oid
    assert_equal subscription[:customer_id], new_subscription.customer.oid
  end

  test 'should not create with a non unique oid' do
    subscription = {}
    subscription[:oid] = subscriptions(:one).oid
    subscription[:quantity] = 1
    subscription[:started_at] = 10.months.ago
    subscription[:cancelled_at] = 10.seconds.ago
    subscription[:plan_id] = plans(:one).oid
    subscription[:customer_id] = customers(:one).oid

    # For subscriptions#create
    assert_no_difference('Subscription.count') do
      post api_v1_subscriptions_path, params: subscription, headers: @headers, as: :json
    end

    assert_response :unprocessable_entity

    # Not testing body right now because error response has to be standardised

    # For subscriptions#update
    patch api_v1_subscription_path(id: subscriptions(:two).oid), params: subscription, headers: @headers, as: :json
    
    assert_response :unprocessable_entity

    # Not testing body right now because error response has to be standardised
  end

  test 'should update a subscription' do
    subscription = subscriptions(:one)
    quantity = 45
    plan_id = plans(:two).oid
    customer_id = customers(:two).oid

    assert_not_equal quantity, subscription.quantity
    assert_not_equal plan_id, subscription.plan.oid
    assert_not_equal customer_id, subscription.customer.oid

    patch api_v1_subscription_path(id: subscription.oid), params: { quantity: quantity, plan_id: plan_id, customer_id: customer_id }, headers: @headers, as: :json

    assert_response :success

    FIELDS.each do |field|
      assert_not_nil body['subscription'][field.to_s]
    end

    subscription.reload

    assert_equal quantity, subscription.quantity
    assert_equal plan_id, subscription.plan.oid
    assert_equal customer_id, subscription.customer.oid
  end
end
