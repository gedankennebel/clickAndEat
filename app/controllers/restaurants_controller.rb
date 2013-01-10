class RestaurantsController < ApplicationController
  before_filter :require_login, :require_unlocked_account
  skip_before_filter :require_login, only: [:index, :show, :menu]
  skip_before_filter :require_unlocked_account, only: [:index, :show, :menu]

  def index
    respond_to do |format|
      format.html {
        @restaurants = Restaurant.all(order: 'created_at DESC')
      }
      format.json {
        expires_in 5.seconds
        render json: {links: [

            {rel: 'current_restaurant', href: restaurant_path(current_user.restaurant)},
            if current_user.branch
              {rel: 'monitor', href: monitor_path(current_user.branch)} #TODO get branch_id from current_user.current_branch
            end
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

  def create_or_edit_menu
    unless current_user.restaurant.nil?
      @restaurant = current_user.restaurant
      @item_category = ItemCategory.new
      @item = Item.new
    else
      redirect_to new_restaurant_path
    end
  end

  def create_item
    @item = Item.new params[:item]
    unless params[:category_id].blank?
      @item.item_category = ItemCategory.find params[:category_id]
      if @item.save
        redirect_to create_or_edit_menu_path
      else
        @restaurant = current_user.restaurant
        @item_category = ItemCategory.new
        render 'create_or_edit_menu'
      end
    else
      @restaurant = current_user.restaurant
      @item_category = ItemCategory.new
      @item.errors.add(:no, 'item category selected')
      render 'create_or_edit_menu'
    end

  end

  def create_item_category
    @item_category = ItemCategory.new params[:item_category]
    @item_category.restaurant = current_user.restaurant
    if @item_category.save
      redirect_to create_or_edit_menu_path
    else
      @restaurant = current_user.restaurant
      @item = Item.new
      render 'create_or_edit_menu'
    end
  end

  def new
    if current_user.restaurant.nil?
      @restaurant = Restaurant.new
      @types = Type.all
    else
      redirect_to user_account_path
    end
  end

  def create
    @restaurant = Restaurant.create_new_restaurant params[:restaurant], params[:type][:name], params[:extra_type]
    if @restaurant.save
      UserAccount.update_role_to_manager current_user, @restaurant
      redirect_to root_path,
                  notice: "Your restaurant has been created!"
    else
      @types = Type.all
      render "new"
    end
  end

  def edit
    unless current_user.restaurant.nil?
      @types = Type.all
      if current_user.restaurant_id.eql? params[:id]
        @restaurant = Restaurant.find params[:id]
      else
        @restaurant = Restaurant.find current_user.restaurant_id
      end
    else
      redirect_to new_restaurant_path
    end
  end

  def update
    if Restaurant.update_restaurant(params[:restaurant], params[:id], params[:type][:name], params[:extra_type], params[:avatar])
      redirect_to root_path, notice: "Your restaurant has been updated!"
    else
      render 'edit'
    end
  end

  private

  def require_unlocked_account
    if current_user.lock
      redirect_to user_accounts_path
    end
  end

end
