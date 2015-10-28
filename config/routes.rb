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
      resources :news do
        post 'sort', on: :collection
        resources :images, only: [:create, :destroy]
      end
      resources :galleries do
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
      
      resources :customers
    end

    resources :tags do
      post 'sort', on: :collection
    end
    
    resources :dashboards
    
    get ':action', controller: 'admin', on: :collection, as: 'action'
  end  
  
  
  resource :accounts, controller: 'accounts', only: [:login, :register] do
    post 'login', controller: 'accounts', action: 'authenticate', on: :collection
    post 'signup', controller: 'accounts', action: 'register', on: :collection
    post 'forgot', controller: 'accounts', action: 'reset', on: :collection

    get 'logout', controller: 'accounts', action: 'logout',  on: :collection
    get 'login', controller: 'accounts', action: 'login', on: :collection
    get 'signup', controller: 'accounts', action: 'signup', on: :collection
    # get ':action', controller: 'accounts', on: :collection, as: 'action', except: ['authenticate', 'register', 'reset']
  end
  
  resource :register, controller: 'register' do
    get ':action', on: :collection, as: 'action'
  end

  resources :orders, only: [:new, :create]
    
  
  get 'services', controller: 'order_services', as: 'order_services', action: 'show'
  post 'services', controller: 'order_services', as: 'request_order_services', action: 'request_service'
  post 'services/payment', controller: 'order_services', as: 'request_payment_order_services', action: 'request_payment'
  get 'services/list', controller: 'order_services', as: 'list_services', action: 'list'
  get 'services/location', controller: 'order_services', as: 'location_order_services', action: 'location'
  get 'services/order', controller: 'order_services', as: 'type_order_services', action: 'order'
  get 'services/confirm', controller: 'order_services', as: 'confirm_order_services', action: 'confirm'
  get 'services/thanks', controller: 'order_services', as: 'thanks_order_services', action: 'thanks'
  
  get 'services/ac', controller: 'order_services', as: 'ac_service_services', action: 'ac_service', service_type: 'ac_service'
  get 'services/cleaning', controller: 'order_services', as: 'cleaning_services', action: 'cleaning', service_type: 'cleaning'
  get 'services/home_improvement', controller: 'order_services', as: 'home_improvement_services', action: 'home_improvement', service_type: 'home_improvement'
  get 'services/gardening', controller: 'order_services', as: 'gardening_services', action: 'gardening', service_type: 'gardening'
  get 'services/auto_wash', controller: 'order_services', as: 'auto_wash_services', action: 'auto_wash', service_type: 'auto_wash'
  get 'services/auto_care', controller: 'order_services', as: 'auto_care_services', action: 'auto_care', service_type: 'auto_care'
  get 'services/massage', controller: 'order_services', as: 'massage_services', action: 'massage', service_type: 'massage'
  get 'services/beauty', controller: 'order_services', as: 'beauty_services', action: 'beauty', service_type: 'beauty'
  get 'services/locksmith', controller: 'order_services', as: 'locksmith_services', action: 'locksmith', service_type: 'locksmith'
  get 'services/henna', controller: 'order_services', as: 'henna_services', action: 'henna', service_type: 'henna'
  get 'services/hijab', controller: 'order_services', as: 'hijab_services', action: 'hijab', service_type: 'hijab'
  get 'services/waxing', controller: 'order_services', as: 'waxing_services', action: 'waxing', service_type: 'waxing'
  get 'services/hair_do', controller: 'order_services', as: 'hair_do_services', action: 'hair_do', service_type: 'hair_do'
  get 'services/pest_control', controller: 'order_services', as: 'pest_control_services', action: 'pest_control', service_type: 'pest_control'
  get 'services/pool', controller: 'order_services', as: 'pool_services', action: 'pool', service_type: 'pool'
  get 'services/grooming', controller: 'order_services', as: 'grooming_services', action: 'grooming', service_type: 'grooming'

  get 'services/:service_type', controller: 'order_services', as: 'action_services', action: 'service'


  get 'payments', controller: 'payments', as: 'payments', action: 'index'
  get 'payments/thanks', controller: 'payments', as: 'thanks_payments', action: 'thanks'
  get 'payments/:action', controller: 'payments', as: 'action_payments'
  post 'payments/process', controller: 'payments', as: 'process_payments', action: 'process_payment'
  
  
  # get ':controller/:action' #/:id', id: nil, format: nil
  
  get '/', controller: 'pages', action: 'show', as: 'home_page'
end
