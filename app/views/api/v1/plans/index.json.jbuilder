json.plans @plans do |plan|
  json.partial! 'api/v1/plans/plan', plan: plan
end
