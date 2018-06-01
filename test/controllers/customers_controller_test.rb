require 'test_helper'

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customers_url
    assert_response :success
  end

  test "should create a customer" do
    random_oid = SecureRandom.hex
    assert_difference('Customer.count') do
      post customers_url, params: { customer: { name: 'Name', email: 'email@example.com', oid: random_oid, notes: 'these are notes' } }
    end

    assert_response :success

    customer = Customer.last
    assert_equal random_oid, customer.oid
  end

  test "should update a customer" do
    customer = customers(:one)
    name = 'Shobhit'
    email = 'email2@example.com'
    
    assert_not_equal name, customer.name
    assert_not_equal email, customer.email
    
    patch customer_path(customer), params: { customer: { name: 'Shobhit', email: 'email2@example.com' } }

    assert_response :success

    customer.reload

    assert_equal name, customer.name
    assert_equal email, customer.email
  end

end
