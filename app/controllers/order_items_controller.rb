class OrderItemsController < ApplicationController

  def new

  end

  def

  def index
    @order_items = Order.find(params[:order_id]).order_items
    render json: @order_items
  end

  def monitor
    @order_items = OrderItem.joins(:order => [:table => :branch]).where('branches.id' => params[:branch_id])
    render json: @order_items
  end

end
