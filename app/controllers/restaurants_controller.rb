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
      redirect_to login_path
    end
  end

  def create
    @restaurant = Restaurant.create_new_restaurant params[:restaurant], params[:type][:name], params[:extra_type]
    if @restaurant.save
      UserAccount.update_to_new_manager current_user, @restaurant
      redirect_to root_path,
                  notice: "Your restaurant has been created!"
    else
      @types = Type.all
      render "new"
    end
  end

  def index
    respond_to do |format|
      format.html {
        @restaurants = Restaurant.all(order: 'created_at DESC')
      }
      # TODO: verursacht FEHLER bei back-button im chrome-browser -> 'current_user.restaurant' (bei safari browser aber kein fehler)
      format.json {
        expires_in 5.seconds
        render json: {links: [
            {rel: 'monitor', href: monitor_path(2)}, #TODO get branch_id from current_user.current_branch
            {rel: 'current_restaurant', href: restaurant_path(current_user.restaurant)}
        ]}
      }
    end
  end

  def edit
    if not current_user.nil?
      if not current_user.restaurant.nil?
        @types = Type.all
        if current_user.restaurant_id.eql? params[:id]
          @restaurant = Restaurant.find params[:id]
        else
          @restaurant = Restaurant.find current_user.restaurant_id
        end
      else
        redirect_to new_restaurant_path
      end
    else
      redirect_to login_path
    end
  end

  def update
    if Restaurant.update_restaurant(params[:restaurant], params[:id], params[:type][:name], params[:extra_type], params[:avatar])
      redirect_to root_path, notice: "Your restaurant has been updated!"
    else
      render 'edit'
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
