json.extract! subscription, :oid, :quantity, :cancelled_at, :started_at

json.customer do 
  json.partial! 'api/v1/customers/customer', customer: subscription.customer
end

json.plan do 
  json.partial! 'api/v1/plans/plan', plan: subscription.plan
end

