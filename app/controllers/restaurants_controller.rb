class RestaurantsController < ApplicationController

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    # set default role for new created user account
    if @restaurant.save
      redirect_to root_path,
                  notice: "Your restaurant has been created!"
    else
      render "new"
    end
  end

  def index
    respond_to do |format|
      format.html {
        @restaurants = Restaurant.all(:order => 'created_at DESC')
      }
      format.json {
        expires_in 5.seconds
        render json: {links: [
            {rel: 'monitor', href: monitor_path(2)}, #TODO get branch_id from current_user.current_branch
            {rel: 'current_restaurant', href: restaurant_path(current_user.restaurant)}
        ]}
      }
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    respond_to do |format|
      format.html
      format.json { expires_in 10.minutes; render json: @restaurant }
    end
  end

  def menu
    @restaurant = Restaurant.find(params[:id])
  end
end
