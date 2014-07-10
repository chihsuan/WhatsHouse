Rails.application.routes.draw do
  get 'password_resets/new'

	resources :users
	resources :password_resets
	resources :sessions, only: [:new, :create, :destroy]
	resources :rent_houses, only: [:create, :destroy]
	resources :sale_houses,  only: [:create, :destroy]
	resources :events 	
	root :to => "content#content"
	get "content" => "content#content"
  	get 'rent_houses/show' => "rent_houses#show"	
  	#get 'sale_houses/show' => "sale_houses#show"
	match '/analysis', to: 'content#analysis', via: 'get'
	match '/rent', to: 'content#rent', via: 'get'
	match '/buy', to: 'content#buy', via: 'get'
	match '/renthouse',  to: 'rent_houses#rentHouse',            via: 'get'
	match '/salehouse',  to: 'sale_houses#sale',            via: 'get'
	match '/signup',  to: 'users#new',            via: 'get'
	match '/signin',  to: 'sessions#new',         via: 'get'
	match '/signout', to: 'sessions#destroy',     via: 'delete'
	match '/about_us', to: 'content#about', via: 'get'
	match '/contact', to: 'content#contact', via: 'get'
	match '/rent_houses/search', to: 'rent_houses#search', via: 'get'


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
