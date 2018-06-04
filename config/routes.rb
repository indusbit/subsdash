Rails.application.routes.draw do
  resources :plans
  resources :customers
  resources :subscriptions

  namespace :api, constraints: { format: 'json' } do
    namespace :v1 do
      resources :plans
      resources :customers
      resources :subscriptions
    end
  end

  root 'subscriptions#index'
end
