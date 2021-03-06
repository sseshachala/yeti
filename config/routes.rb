Yeti::Application.routes.draw do

  
  resources :invoices

  resources :reports

  resources :rmonitors

  resources :users

  resources :sessions , :only => [:new, :create, :destroy]

  match '/update_email/:id', :to => 'users#update_email'

  match '/update_password/:id', :to => 'users#update_password'

  match '/billing_history/:id', :to => 'invoices#billing_history'

  match '/send_password_reset_code', :to => 'sessions#send_password_reset_code'

  match '/reset_password/:id/:code', :to => 'users#verify_password_reset_code'

  match '/restore_password', :to => 'users#restore_password'

  match '/forgot_password', :to => 'sessions#forgot_password'

  match '/payment_method', :to => 'users#add_payment_method'

  match '/confirm/:id', :to => 'users#confirm'
  
  match '/authorize_payments', :to => 'users#authorize_payments'

  match '/authorized', :to => 'users#authorized'
  
  match '/send_contact_message', :to => 'pages#send_contact_message'

  match '/signup', :to => 'users#new'

  match '/signin', :to => 'sessions#new'

  match '/signout', :to => 'sessions#destroy'
  
  match '/rmonitors/:id/pause', :to => 'rmonitors#pause'

  match '/rmonitors/:id/restart', :to => 'rmonitors#restart'

  match 'dashboard/:id',  :to => 'rmonitors#dashboard'

  match '/reports/:id/stop', :to => 'reports#stop'

  match '/reports/:id/restart', :to => 'reports#restart'
  
  match '/send_confirmation_email', :to => 'users#send_confirmation_email'

  match '/' => 'pages#home'

  match '/aboutus' => 'pages#aboutus'

  match '/contact' => 'pages#contact'
  
  match '/faq' => 'pages#faq'

  match '/tos' => 'pages#tos'

  match '/privacy' => 'pages#privacy'


  

  get "pages/home"

  get "pages/contact"

  get "pages/login"

  get "pages/dashboard"

  get "pages/aboutus"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => 'pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
