Rails.application.routes.draw do
  root 'staticpages#top'
  # ユーザー
  resources :users, only: %i[new create]
  # ログイン
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
  # WishList
  resources :wish_lists, only: %i[show index]
  post 'lock' => 'wish_lists#lock', :as => :lock_list
  # Wish
  resources :wishes, only: %i[new create edit update destroy]
  post 'check/:id' => 'wishes#check', :as => :check_wish

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
