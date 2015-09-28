Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  # =========================================
  # =========================================
  # =========================================
    
  resource :admin, controller: 'admin' do
    # Directs /admin/products/* to Admin::ProductsController
    # (app/controllers/admin/products_controller.rb)
    # get 'settings/:action', controller: 'settings'
    
    post 'login', controller: 'admin', action: 'authenticate', on: :collection
    post 'signup', controller: 'admin', action: 'register', on: :collection
    post 'forgot', controller: 'admin', action: 'reset', on: :collection
        
    resource :settings do 
      resource :profiles, except: [:new, :edit, :create, :destroy]
      resources :users
      resources :roles do
        post 'sort', on: :collection
      end
      get ':action', on: :collection, as: 'action'
    end
    
    resource :contents do
      resources :banners do
        post 'sort', on: :collection
      end
      
      resources :comics do
        resources :episodes do
          post 'sort', on: :collection
          resources :images, only: [:create, :destroy]
        end
        post 'sort', on: :collection
      end
      
      resources :news do
        post 'sort', on: :collection
        resources :images, only: [:create, :destroy]
      end
      resources :galleries do
        post 'sort', on: :collection
        resources :images, only: [:create, :destroy]
      end
      resources :events do
        post 'sort', on: :collection
        resources :images, only: [:create, :destroy]
      end
      resources :services do
        post 'sort', on: :collection
        resources :images, only: [:create, :destroy]
      end
      resource :services do
        get 'searches/:category', controller: 'searches', on: :collection, action: 'index', as: 'searches', category: 'all'
        post 'searches/:category', controller: 'searches', on: :collection, action: 'show', as: 'results', category: 'all'
      end
      
      resources :categories do
        post 'sort', on: :collection
      end
    end

    resource :store, controller: 'store' do
      resources :products do 
        post 'sort', on: :collection
        # get ':action', on: :collection, as: 'action'
        resources :images, only: [:create, :destroy]
        resources :product_items, as: 'items' do
          post 'sort', on: :collection
        end
      end
      
      resources :orders, except: [:new, :create, :destroy] do
        post 'cancel/:id', on: :collection, action: 'cancel', as: 'cancel'
        post 'revert/:id', on: :collection, action: 'revert', as: 'revert'
        post 'process/:id', on: :collection, action: 'do_process', as: 'process'
        
        # get ':id/:status', on: :collection, only: [:open, :pending_payment, :pending_work, 
        #                                             :processing, :processed, :cancelled]
        get 'open', action: 'open', on: :collection, as: 'open'
        get 'pending_payment', action: 'pending_payment', on: :collection, as: 'pending_payment'
        get 'pending_work', action: 'pending_work', on: :collection, as: 'pending_work'
        get 'processing', action: 'processing', on: :collection, as: 'processing'
        get 'processed', action: 'processed', on: :collection, as: 'processed'
        get 'cancelled', action: 'cancelled', on: :collection, as: 'cancelled'
        
        get ':id/:action', on: :collection, as: 'action', id: nil
      end
      
      resources :collections do
        post 'sort', on: :collection
        get ':action', on: :collection, as: 'action'
      end
      
      resources :customers
    end

    resources :tags do
      post 'sort', on: :collection
    end

    resource :mailings do
      resources :campaigns, controller: 'mailing_campaigns'
      resources :lists, controller: 'mailing_lists'
    end
    
    resources :dashboards
        
    # resources :maps do 
    #   get ':action', on: :collection, as: 'action'
    # end        
    # resources :forms
    
    get ':action', controller: 'admin', on: :collection, as: 'action'
  end  
  
  
  resource :accounts, controller: 'accounts', only: [:login, :register] do
    post 'login', controller: 'accounts', action: 'authenticate', on: :collection
    post 'signup', controller: 'accounts', action: 'register', on: :collection
    post 'forgot', controller: 'accounts', action: 'reset', on: :collection

    get 'logout', on: :collection
    get 'login', on: :collection
    get 'signup', on: :collection
    # get ':action', controller: 'accounts', on: :collection, as: 'action', except: ['authenticate', 'register', 'reset']
  end
  
  resource :register, controller: 'register' do
    get ':action', on: :collection, as: 'action'
  end

  resources :orders, only: [:new, :create]
  
  post 'mailing_lists/signup', controller: 'mailing_lists', action: 'signup'
  
  # get ':controller/:action' #/:id', id: nil, format: nil
  
  get '/', controller: 'pages', action: 'show'  
end
