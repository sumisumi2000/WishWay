Rails.application.routes.draw do
  root 'staticpages#top'
  # ユーザー
  resources :users, only: %i[new create show update]
  # ログイン
  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: "user_sessions#create"
  delete 'logout', to: 'user_sessions#destroy', as: :logout
  # WishList
  resources :wish_lists, only: %i[show index edit update destroy] do
    resources :favorites, only: %i[create destroy], shallow: true
    get :search, on: :collection
  end
  resources :favorites, only: %i[index] do
    get :search, on: :collection
  end
  post 'lock', to: 'wish_lists#lock'
  post 'unlock', to: 'wish_lists#unlock'
  # Wish
  resources :wishes, only: %i[new create edit update destroy]
  post 'check/:id', to: 'wishes#check', as: :check
  post 'uncheck/:id', to: 'wishes#uncheck', as: :uncheck
  get 'wishes/:id', to: 'wishes#add', as: :add
  # パスワードリセット
  resources :password_resets, only: %i[new create edit update]
  # Google 認証
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", as: :auth_at_provider
  # 通知
  resources :notifications, only: %i[edit update]
  # 問い合わせフォーム
  get '/form', to: 'staticpages#form', as: :inquiry_form
  get '/policy', to: 'staticpages#policy', as: :privacy_policy

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up", to: "rails/health#show", as: :rails_health_check

  # 開発環境でのメール確認
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
