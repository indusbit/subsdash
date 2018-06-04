json.customer do 
  json.partial! 'api/v1/customers/customer', customer: @customer
end