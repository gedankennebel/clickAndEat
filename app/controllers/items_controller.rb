class ItemsController < ApplicationController

  def index
    @items = Item.where(item_category_id: params[:item_category_id])
    expires_in 10.minutes
    render json: @items
  end

end
