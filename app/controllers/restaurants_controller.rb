class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all(:order => 'created_at DESC')
  end

  def image
    send_data @restaurants.picture, :type => 'image/png', :disposition => 'inline'
  end

end
