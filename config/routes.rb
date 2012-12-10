ClickAndEat::Application.routes.draw do
  resources :orders
  resources :user_accounts, only: [:new, :create]
  get "login" => "sessions#new", as: "login"
  post "session" => "sessions#create", as: "sessions"
  #get orders #index
  root to: 'restaurants#index'
end