class Plan < ApplicationRecord
  validates_presence_of :oid
  validates_uniqueness_of :oid

  has_many :subscriptions
  has_many :customers, through: :subscriptions

  def monthly_amount
    case interval
    when "yearly"
      amount / 12
    when "monthly"
      amount
    when "weekly"
      amount * 4
    when "daily"
      amount * 30
    end
  end

  def total_monthly
    subscriptions.inject(0) do |sum, subscription|
      sum + subscription.monthly_revenue
    end
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
