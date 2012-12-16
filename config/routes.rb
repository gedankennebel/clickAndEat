ClickAndEat::Application.routes.draw do
  # Log-In & session routes
  get "login" => "sessions#new"
  post "sessions" => "sessions#create"
  delete "logout" => "sessions#destroy"

  #Picture
  get "/items/:item_id/picture" => "picture#get_item_picture"
  get "/restaurants/:restaurant_id/picture" => "picture#get_restaurant_picture"

  get "/restaurants/:id/menu" => "restaurants#menu"

  #post "orders/{order_id}/order_items" => "order_item#create"

  #get "orders/{order_id}/order_items/new" => "order_item#new"

  #get "order_item/list"

  #resources :orders
  resources :user_accounts, only: [:new, :create]

  #ItemCategory
  resources :restaurants do
    resources :item_categories
  end

  #Item
  resources :item_categories do
    resources :items
  end

  #OrderItem
  get "branches/:branch_id/order_items" => "order_items#monitor"

  #Order
  resources :orders do
    resources :order_items
  end

  root to: 'restaurants#index'
end
