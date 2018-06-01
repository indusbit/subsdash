Rails.application.routes.draw do
  resources :plans
  resources :customers
  resources :subscriptions

  namespace :api do
    namespace :v1 do
      resources :plans
    end
  end

  root 'subscriptions#index'
end
