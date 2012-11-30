ClickAndEat::Application.routes.draw do
  post "orders/{order_id}/order_items" => "order_item#create"

  get "orders/{order_id}/order_items/new" => "order_item#new"

  get "order_item/list"

  resources :orders
  #get orders#index
  #root to: orders#index
end
