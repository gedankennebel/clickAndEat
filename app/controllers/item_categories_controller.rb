class ItemCategoriesController < ApplicationController

  def index
    @item_categories = ItemCategory.where(restaurant_id: Branch.find(params[:restaurant_id]))
    expires_in 10.minutes
    render json: @item_categories
  end

end
