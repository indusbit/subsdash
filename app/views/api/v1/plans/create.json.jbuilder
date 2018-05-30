json.message "Plan created successfully."
json.plan do 
 json.merge! @plan.attributes
end