require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  test "oid should be unique" do
    customer = customers(:one)
    new_customer = Customer.new oid: customer.oid
    assert !new_customer.save
    assert_includes new_customer.errors.details[:oid], { error: :taken, value: customer.oid }
  end
end

# == Schema Information
#
# Table name: customers
#
#  id         :bigint(8)        not null, primary key
#  email      :string
#  name       :string
#  notes      :text
#  oid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_customers_on_oid  (oid)
#
