json.subscription do 
  json.partial! 'api/v1/subscriptions/subscription', subscription: @subscription
end