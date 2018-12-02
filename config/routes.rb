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
      get 'merchants/find_all', to: 'find_merchants#index'
      get 'items/find', to: 'find_items#show'
      get 'items/find_all', to: 'find_items#index'
      get 'invoices/find', to: 'find_invoices#show'
      get 'invoices/find_all', to: 'find_invoices#index'
      get 'invoice_items/find', to: 'find_invoice_items#show'
      get 'invoice_items/find_all', to: 'find_invoice_items#index'
    end
  end
end
