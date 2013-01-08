ClickAndEat::Application.routes.draw do
  # Log-In & session routes
  get "login" => "sessions#new"
  post "sessions" => "sessions#create"
  delete "logout" => "sessions#destroy"

  #Picture
  get "/items/:item_id/picture" => "picture#get_item_picture"

  get "/restaurants/:id/menu" => "restaurants#menu"
  get "/user_account" => "user_accounts#index"
  get "/user_account/filter_definition" => "user_accounts#get_filter_definition"
  put "/user_account/filter_definition" => "user_accounts#save_filter_definition"

  get "/joinRestaurant" => "user_accounts#join_restaurant"
  post "/restaurantApply" => "user_accounts#apply_to_restaurant_as_employee"

  resources :user_accounts, only: [:new, :create, :index]

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

  resources :messages

  match "branches/:branch_id/order_items", to: "order_items#monitor", as: :monitor

  get "accept_employee/:message_id" => "user_accounts#accept_employee"
  get "decline_employee/:message_id" => "user_accounts#decline_employee"

  root to: 'restaurants#index'
end
