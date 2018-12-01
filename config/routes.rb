Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
      resources :customers, only: [:index]
      resources :invoice_items, only: [:index]
    end
  end
end
