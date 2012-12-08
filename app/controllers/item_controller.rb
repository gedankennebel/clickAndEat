class ItemController < ApplicationController

  def list
    @items = Item.where(item_category_id: params[:item_category_id])
    render json: @items
  end

end
