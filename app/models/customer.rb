class Customer < ApplicationRecord
  validates_uniqueness_of :oid

  has_many :subscriptions
  has_many :plans, through: :subscriptions
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
