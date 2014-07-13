Rails.application.routes.draw do
	resources :users
	resources :password_resets
	resources :sessions, only: [:new, :create, :destroy]
	resources :rent_houses, only: [:create, :destroy]
	resources :sale_houses,  only: [:create, :destroy]
	root :to => "content#content"
	
	# main page router
	get 'content' => 'content#content'
	get 'rent' => 'content#rent'
	get 'about_us' => 'content#about'
	get 'contact' => 'content#contact'
	
	# login system router
	match '/signup',  to: 'users#new',            via: 'get'
	match '/signin',  to: 'sessions#new',         via: 'get'
	match '/signout', to: 'sessions#destroy',     via: 'delete'
  	get 'password_resets/new'
	
	# rent house router
	match '/renthouse',  to: 'rent_houses#rentHouse',            via: 'get'
	match '/salehouse',  to: 'sale_houses#sale',            via: 'get'
	
	# ajax router
	match '/events/advancedSearch', to: 'events#advancedSearch', via: 'get'
	match '/events/search', to: 'events#search', via: 'get'
	
	# socialnewtwork login router
	match 'auth/failure', to: redirect('/'), via: [:get, :post]
	match 'auth/:provider/callback', to: 'sessions#facebook', via: [:get, :post]

	match '/analysis', to: 'content#analysis', via: 'get'
	match '/buy', to: 'content#buy', via: 'get'
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
end
