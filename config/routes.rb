ClickAndEat::Application.routes.draw do
  # Log-In & session routes
  get "login" => "sessions#new"
  post "sessions" => "sessions#create"
  delete "logout" => "sessions#destroy"

  #Picture
  get "/items/:item_id/picture" => "picture#get_item_picture"
  get "/restaurants/:restaurant_id/picture" => "picture#get_restaurant_picture"

  get "/restaurants/:id/menu" => "restaurants#menu"

  resources :user_accounts, only: [:new, :create]

  resources :restaurants do
    resources :item_categories
  end

  resources :item_categories do
    resources :items
  end


  resources :orders, only: [] do
    resources :order_items
  end

  resources :branches do
    resources :orders
  end
  get "branches/:branch_id/order_items" => "order_items#monitor"

  root to: 'restaurants#index'
end
