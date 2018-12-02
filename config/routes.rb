Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/',to: 'merchants#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/items', to: 'items_association#index'
        get '/:id/invoices', to: 'invoices_association#index'
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
        get '/:id/merchant', to: 'merchant_association#show'
        get '/:id/invoice_items', to: 'invoice_items_association#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :invoices do
        get '/',to: 'invoices#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/items', to: 'items_association#index'
        get '/:id/merchant', to: 'merchant_association#show'
        get '/:id/customer', to: 'customer_association#show'
        get '/:id/transactions', to: 'transactions_association#index'
        get '/:id/invoice_items', to: 'invoice_items_association#index'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :invoice_items do
        get '/',to: 'invoice_items#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/item', to: 'item_association#show'
        get '/:id/invoice', to: 'invoice_association#show'
      end
    end
  end
end
