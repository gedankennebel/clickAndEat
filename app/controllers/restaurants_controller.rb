class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all(:order => 'created_at DESC')
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def menu
    @restaurant = Restaurant.find(params[:id])
  end
end
