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
    end
  end
end
