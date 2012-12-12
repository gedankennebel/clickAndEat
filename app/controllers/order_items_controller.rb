class OrderItemsController < ApplicationController

  def new

  end


  def index
    @order_items = OrderItem.where(order_id: params[:order_id])
    render json: @order_items
  end

  def show
    @order_item = OrderItem.find(params[:id])
    render json: @order_item
  end

  def create
    @order_item = OrderItem.new.from_json(request.body)
    @order_item.save!
    render status: 201, nothing: true, location: order_order_item_url(@order_item.order, @order_item)
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.from_json(request.body)
    @order_item.save!
    render status: 204, nothing: true
  end

  def monitor
    @order_items = OrderItem.joins(:order => [:table => :branch]).where('branches.id' => params[:branch_id])
    render json: @order_items
  end

end
