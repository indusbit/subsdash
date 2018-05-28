require 'test_helper'

class PlanTest < ActiveSupport::TestCase
  test "oid should be unique" do
    plan = plans(:one)
    new_plan = Plan.new oid: plan.oid
    assert !new_plan.save
    assert_includes new_plan.errors.details[:oid], { error: :taken, value: plan.oid }
  end
end

# == Schema Information
#
# Table name: plans
#
#  id             :bigint(8)        not null, primary key
#  amount         :decimal(18, 4)
#  currency       :string
#  interval       :string
#  interval_count :integer
#  name           :string
#  oid            :string
#  platform       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_plans_on_interval  (interval)
#  index_plans_on_oid       (oid)
#
