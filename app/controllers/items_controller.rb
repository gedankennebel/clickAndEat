class ItemsController < ApplicationController

  def index
    @items = Item.where(item_category_id: params[:item_category_id])
    render json: @items
  end

end
