json.subscriptions @subscriptions do |subscription|
  json.partial! 'api/v1/subscriptions/subscription', subscription: subscription
end
