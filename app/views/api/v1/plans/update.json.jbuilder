json.message "Plan updated successfully."
json.plan do 
  json.partial! 'api/v1/plans/plan', plan: @plan
end