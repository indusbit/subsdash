json.customers @customers do |customer|
  json.partial! 'api/v1/customers/customer', customer: customer
end
