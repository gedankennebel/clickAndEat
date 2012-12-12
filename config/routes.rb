ClickAndEat::Application.routes.draw do

  #ItemCategory
  resources :restaurants do
    resources :item_categories
  end

  #Item
  resources :item_categories do
    resources :items
  end

  #OrderItem
  get "branches/:branch_id/order_items" => "order_item#monitor"

  #Order
  resources :orders do
    resources :order_items
  end

  #Picture
  get "/items/:item_id/picture" => "picture#get_picture"

end
