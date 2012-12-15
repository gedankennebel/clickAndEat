class PictureController < ApplicationController

  def get_item_picture
    @item = Item.find(params[:item_id])
    fresh_when :last_modified => @item.updated_at, :etag => @item
    if @item.picture
      @picture = item.picture
    else
      if @item.item_category.default_picture
        @picture = @item.item_category.default_picture
      else
        puts 'send_file'
        send_file Rails.root.join("public", "no_image.jpg"), type: "image/jpeg", disposition: "inline"
        return
      end
    end

    send_data @picture, type: 'image/jpeg', disposition: 'inline'
  end

  def get_restaurant_picture
    @restaurant = Restaurant.find(params[:restaurant_id])
    fresh_when :last_modified => @restaurant.updated_at, :etag => @restaurant
    if @restaurant.picture
      send_data @restaurant.picture, type: 'image/png', disposition: 'inline'
    end
  end

end
