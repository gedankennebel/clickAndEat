class PictureController < ApplicationController

  after_filter :set_cache_headers

  def get_item_picture
    @item = Item.find(params[:item_id])
    #fresh_when :last_modified => @item.updated_at, :etag => @item
    if @item.picture
      @picture = @item.picture
    else
        puts 'send_file'
        send_file Rails.root.join("public", "no_image.jpg"), type: "image/jpeg", disposition: "inline"
        return
    end
    send_data @picture, type: 'image/jpeg', disposition: 'inline'
  end

  private
  def set_cache_headers
    expires_in 30.minutes
  end

end
