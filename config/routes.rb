Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index]
      resources :customers, only: [:index]
      resources :invoice_items, only: [:index]
      resources :invoices, only: [:index]
      resources :items, only: [:index]
      resources :transactions, only: [:index]
    end
  end

  namespace :api do
    namespace :v1 do
      get 'transactions/find', to: 'find_transactions#show'
      get 'transactions/find_all', to: 'find_transactions#index'
      get 'customers/find', to: 'find_customers#show'
      get 'customers/find_all', to: 'find_customers#index'
      get 'merchants/find', to: 'find_merchants#show'
    end
  end
end
