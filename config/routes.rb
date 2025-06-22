Rails.application.routes.draw do
  # Health check route
  get "status", to: "rails/health#show", as: :rails_health_check

  # JSON API routes
  namespace :api, defaults: { format: :json } do
    resources :carts, only: [:index, :create, :show] do
      resources :cart_items, only: [:create]
    end

    resources :products, only: [:index]
  end
end
