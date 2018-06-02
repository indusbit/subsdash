require 'test_helper'

class Api::V1::CustomersControllerTest < ActionDispatch::IntegrationTest
  FIELDS = [:oid, :name, :email, :notes]

  def body
    @body ||= JSON @response.body
  end

  setup do
    @headers = {}
    @headers['Accept'] = Mime[:json].to_s
    @headers['Content-Type'] = Mime[:json].to_s    
  end

  test 'should fetch all customers' do
    get api_v1_customers_path, headers: @headers
    assert_response :success

    assert_instance_of Array, body['customers']
    assert_equal Customer.count, body['customers'].count

    body['customers'].each do |customer|
      FIELDS.each do |field|
        assert_not_nil customer[field.to_s]
      end
    end
  end

  test 'should fetch a specific customer' do
    customer = customers :one
    get api_v1_customer_path(id: customer.oid), headers: @headers
    assert_response :success

    assert_instance_of Hash, body['customer']

    FIELDS.each do |field|
      assert_equal customer[field], body['customer'][field.to_s]
    end
  end

  test 'should throw not found if customer not found' do
    oid = 'NotInDatabase'
    assert_empty Customer.where(oid: oid)

    # for customers#show
    get api_v1_customer_path(id: oid), headers: @headers

    assert_response :not_found

    # for customers#update
    patch api_v1_customer_path(id: oid), headers: @headers

    assert_response :not_found
  end

  test 'should create a customer' do
    customer = {}
    customer[:oid] = SecureRandom.hex
    customer[:name] = 'New Name'
    customer[:email] = 'testcustomer1@app.com'
    customer[:notes] = 'Just some notes'

    assert_difference('Customer.count') do
      post api_v1_customers_path, params: customer, headers: @headers, as: :json
    end

    assert_response :success

    new_customer = Customer.last

    FIELDS.each do |field|
      assert_equal customer[field], body['customer'][field.to_s]
      assert_equal customer[field], new_customer[field]
    end
  end

  test 'should not create with a non unique oid' do
    customer = {}
    customer[:oid] = customers(:one).oid
    customer[:name] = 'New Name'
    customer[:email] = 'testcustomer1@app.com'
    customer[:notes] = 'Just some notes'

    # For customers#create
    assert_no_difference('Customer.count') do
      post api_v1_customers_path, params: customer, headers: @headers, as: :json
    end

    assert_response :unprocessable_entity

    # Not testing body right now because error response has to be standardised

    # For customers#update
    patch api_v1_customer_path(id: customers(:two).oid), params: customer, headers: @headers, as: :json
    
    assert_response :unprocessable_entity

    # Not testing body right now because error response has to be standardised
  end

  test 'should update a customer' do
    customer = customers(:one)
    name = 'New Name Customer'
    email = 'NewEmail@customer.com'

    assert_not_equal name, customer.name
    assert_not_equal email, customer.email

    patch api_v1_customer_path(id: customer.oid), params: { name: name, email: email }, headers: @headers, as: :json

    assert_response :success

    FIELDS.each do |field|
      assert_not_nil body['customer'][field.to_s]
    end

    customer.reload

    assert_equal name, customer.name
    assert_equal email, customer.email
  end

  # Not implemented because functionality has not been decided
  # test 'should delete a customer'
end
