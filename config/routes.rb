ClickAndEat::Application.routes.draw do

  #ItemCategory
  get "restaurants/:restaurant_id/item_categories" => "item_category#list"

  #Item
  get "item_categories/:item_category_id/items" => "item#list"

  #OrderItem
  #post "orders/:order_id/order_items" => "order_item#create"
  get "orders/:order_id/order_items" => "order_item#index"
  get "branches/:branch_id/order_items" => "order_item#monitor"

  #Order
  resources :orders
  #get orders#index
  #root to: orders#index
end
