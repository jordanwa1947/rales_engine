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
      namespace :customers do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :transactions do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :invoice_items do
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end
end
