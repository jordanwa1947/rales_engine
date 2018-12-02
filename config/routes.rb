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
      namespace :merchants do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/items', to: 'item_association#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      get 'transactions/find', to: 'find_transactions#show'
      get 'transactions/find_all', to: 'find_transactions#index'
      get 'customers/find', to: 'find_customers#show'
      get 'customers/find_all', to: 'find_customers#index'
      get 'items/find', to: 'find_items#show'
      get 'items/find_all', to: 'find_items#index'
      get 'invoices/find', to: 'find_invoices#show'
      get 'invoices/find_all', to: 'find_invoices#index'
      get 'invoice_items/find', to: 'find_invoice_items#show'
      get 'invoice_items/find_all', to: 'find_invoice_items#index'
    end
  end
end
