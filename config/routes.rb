Rails.application.routes.draw do
  root 'staticpages#top'
  # ユーザー
  resources :users, only: %i[new create]
  # ログイン
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  # WishList
  resources :wish_lists, only: %i[show index]
  post 'lock', to: 'wish_lists#lock'
  post 'unlock', to: 'wish_lists#unlock'
  # Wish
  resources :wishes, only: %i[new create edit update destroy]
  post 'check/:id', to: 'wishes#check', as: :check
  post 'uncheck/:id', to: 'wishes#uncheck', as: :uncheck

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
