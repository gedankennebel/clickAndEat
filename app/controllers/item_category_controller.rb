class ItemCategoryController < ApplicationController

  def list
    @item_category = ItemCategory.where(restaurant_id: params[:restaurant_id])
    render json: @item_category
  end

end
