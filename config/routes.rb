Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/',to: 'merchants#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/items', to: 'item_association#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/',to: 'customers#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :transactions do
        get '/',to: 'transactions#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/',to: 'items#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get '/',to: 'invoices#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/items', to: 'item_association#index'
        get '/:id/transactions', to: 'transaction_association#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :invoice_items do
        get '/',to: 'invoice_items#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
      end
    end
  end
end
