class Subscription < ApplicationRecord
  validates_presence_of :oid
  validates_uniqueness_of :oid
  
  belongs_to :customer
  belongs_to :plan

  def monthly_revenue
    quantity * plan.monthly_amount
  end
end

# == Schema Information
#
# Table name: subscriptions
#
#  id           :bigint(8)        not null, primary key
#  cancelled_at :datetime
#  oid          :string
#  quantity     :integer
#  started_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  customer_id  :bigint(8)
#  plan_id      :bigint(8)
#
# Indexes
#
#  index_subscriptions_on_customer_id  (customer_id)
#  index_subscriptions_on_oid          (oid)
#  index_subscriptions_on_plan_id      (plan_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (plan_id => plans.id)
#
