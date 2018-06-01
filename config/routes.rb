Rails.application.routes.draw do
  resources :plans
  resources :customers

  namespace :api do
    namespace :v1 do
      resources :plans
    end
  end

end
