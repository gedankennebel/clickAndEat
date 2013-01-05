class RestaurantsController < ApplicationController

  def new
    if not current_user.nil?
      if current_user.restaurant.nil?
        @restaurant = Restaurant.new
        @types = Type.all
      else
        redirect_to user_account_path
      end
    else
      redirect_to new_user_account_path
    end
  end

  def create
    @restaurant = Restaurant.new(params[:restaurant])
    @types = params[:type][:name]
    @types.each do |name|
      @restaurant.types << Type.find_by_name(name)
    end
    # set default role for new created user account
    if @restaurant.save
      current_user.roles = Role.find_all_by_name("manager")
      redirect_to root_path,
                  notice: "Your restaurant has been created!"
      current_user.restaurant = Restaurant.find_by_name(params[:restaurant][:name])
      current_user.save!
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
