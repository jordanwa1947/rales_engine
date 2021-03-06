Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/',to: 'merchants#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/random.json', to: 'random_merchant#show'
        get '/:id/items', to: 'items_association#index'
        get '/:id/invoices', to: 'invoices_association#index'
        get '/most_revenue', to: 'merchants_revenue#index'
        get '/most_items', to: 'merchants_sold#index'
        get '/revenue', to: 'merchants_revenue#show'
        get '/:id/revenue', to: 'merchants_revenue#show'
        get '/:id/favorite_customer', to: 'favorite_customer#show'
        get '/:id/customers_with_pending_invoices', to: 'pending#index'
        get '/:id',to: 'merchants#show'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :customers do
        get '/',to: 'customers#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/invoices', to: 'invoices_association#index'
        get '/:id/transactions', to: 'transactions_association#index'
        get '/:id/favorite_merchant', to: 'favorite_merchant#show'
        get '/:id', to: 'customers#show'
      end
    end
  end

  namespace :api do
    namespace :v1 do
      namespace :transactions do
        get '/', to: 'transactions#index'
        get '/find', to: 'find#show'
        get '/find_all', to: 'find#index'
        get '/:id/invoice', to: 'invoice_association#show'
        get '/:id', to: 'transactions#show'
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
        get '/most_revenue', to: 'items_revenue#index'
        get '/most_items', to: 'items_sold#index'
        get '/:id/best_day', to: 'item_date#show'
        get '/:id', to: 'items#show'
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
        get '/:id', to: 'invoices#show'
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
        get '/:id', to: 'invoice_items#show'
      end
    end
  end
end
