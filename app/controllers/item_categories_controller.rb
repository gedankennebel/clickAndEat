class ItemCategoriesController < ApplicationController

  def index
    @item_categories = ItemCategory.where(restaurant_id: Branch.find(params[:restaurant_id]))
    render json: @item_categories
  end

end
