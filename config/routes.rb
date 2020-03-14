Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :root, to: 'welcome#index'

  resources :merchants do
    resources :items, only: [:index]
  end

  # get '/merchants/items', to: merchants/items#index

  resources :items, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  # get '/items', to: 'items#index'
  # get '/items/:id', to: 'items#show'
  # get /items/reviews/new, to: 'items/reviews#new'
  # post /items/reviews, to: 'items/reviews#create'

  resources :reviews, only: [:edit, :update, :destroy]

  # get '/reviews/:id/edit', to: 'reviews#edit'
  # patch '/reviews/:id', to: 'reviews#update'
  # delete '/reviews/:id', to: 'reviews#destroy'

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  # resources :cart, only: [:show, :create, :destroy, :update]

  get '/registration', to: 'users#new', as: :registration
  #  resources :registration, only: [:new]
  resources :users, only: [:create, :update]
  # post '/users', to: users#create
  patch '/user/:id', to: 'users#update'
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'
  post '/orders', to: 'user/orders#create'
  get '/profile/orders', to: 'user/orders#index'
  get '/profile/orders/:id', to: 'user/orders#show'
  delete '/profile/orders/:id', to: 'user/orders#cancel'
  # resources :user, only: [:update, :show, :edit] do
  #   resources :profile, only: [:edit]
  #   resources :orders, only: [:index, :show, :destroy]
  # end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'
  # resources :sessions do
  #   resources :login, only: [:new, :login, :logout]
  # end

  namespace :merchant do
    get '/', to: 'dashboard#index', as: :dashboard
    get "/discounts/:id/edit", to: "discounts#edit"

    # resources :merchant, only: [:index] do
    #   resources :discounts, only: [:edit]
    # end
    resources :discounts, only: [:index, :new, :create, :update, :destroy]
    # get '/merchant/discounts', to: 'merchant/discounts#index'
    # get '/merchant/discounts/new', to: 'merchant/discounts#new'
    # post '/merchant/discounts', to: 'merchant/discounts#create'
    # patch '/merchant/discounts/:id', to: 'merchant/discounts#update'
    # delete '/merchant/discounts/:id', to: 'merchant/discounts#destroy'
    resources :orders, only: :show
    # get '/merchant/orders/:id', to: 'merchant/orders#show'
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    # get '/merchant/items', to: 'merchant/items#index'
    # get '/merchant/items/new', to: 'merchant/items#new'
    # post '/merchant/items', to: 'merchant/items#create'
    # get '/merchant/items/edit', to: 'merchant/items#edit'
    # patch '/merchant/items/:id', to: 'merchant/items#update'
    # delete '/merchant/items/:id', to: 'merchant/items#destroy'
    put '/items/:id/change_status', to: 'items#change_status'
    # resources :items, only: [:show, :edit]
    get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'

  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :merchants, only: [:show, :update]
    resources :users, only: [:index, :show]
    patch '/orders/:id/ship', to: 'orders#ship'
  end
end
# resources :admin only: [:index] do
# get '/merchants/:id', to: 'merchants#show'
# patch '/merchants/:id', to: 'merchants#update'
# get '/users', to: 'users#index'
# get '/users/:id', to: 'users#show'
# resources :orders only: [:show]
