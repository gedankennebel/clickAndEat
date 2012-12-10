ClickAndEat::Application.routes.draw do
  post "orders/{order_id}/order_items" => "order_item#create"

  get "orders/{order_id}/order_items/new" => "order_item#new"

  get "order_item/list"

  resources :orders
  resources :user_accounts, only: [:new, :create]
  get "login" => "sessions#new", as: "login"
  post "session" => "sessions#create", as: "sessions"
  #get orders #index
  root to: 'restaurants#index'
end
