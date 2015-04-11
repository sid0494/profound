Rails.application.routes.draw do

  get 'learning_topics/index'

  get 'learning_topics/show'

  get 'learning_topics/new'

  post 'learning_topics/create'

  get 'learning_topics/edit'

  patch 'learning_topics/update'

  get 'learning_topics/delete'

  post 'learning_topics/destroy'

  get 'learning_topics/my_topics'

  get 'learning_topics/commend'

  get 'discussions/index'

  get 'discussions/new'

  post 'discussions/create'

  get 'discussions/delete'

  post 'discussions/destroy'

  get 'discussions/my_discussions'

  get 'discussions/show'

  get 'discussions/edit'
  
  patch 'discussions/update'

  post 'discussions/reply'

  get 'projects/index'

  get 'projects/show'

  get 'projects/new'

  get 'projects/edit'

  get 'projects/delete'

  post 'projects/create'

  get 'projects/my_projects'

  patch 'projects/update'

  post 'projects/destroy'

  get 'projects/commend'

  get 'projects/share'


  get 'dashboard/home'

  get 'dashboard/about_us'

  get 'dashboard/contact_us'

  get 'dashboard/show_profile'

  get 'dashboard/help'

  get 'dashboard/faqs'

  post 'dashboard/search'

  get 'dashboard/follow'

  get 'dashboard/unfollow'

  get 'dashboard/followers'

  get 'dashboard/followings'


  devise_for :users, controllers: { 
    sessions: "users/sessions",
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    unlocks: "users/unlocks" 
  }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root to: "dashboard#home"


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
