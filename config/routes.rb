ClickAndEat::Application.routes.draw do
  # Log-In & session routes
  get "login" => "sessions#new"
  post "sessions" => "sessions#create"
  delete "logout" => "sessions#destroy"

  post "orders/{order_id}/order_items" => "order_item#create"

  get "orders/{order_id}/order_items/new" => "order_item#new"

  get "order_item/list"

  resources :orders
  resources :user_accounts, only: [:new, :create]
  root to: 'restaurants#index'
end
