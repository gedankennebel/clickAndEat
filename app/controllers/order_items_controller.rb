class OrderItemsController < ApplicationController

  def index
    @order_items = OrderItem.where(order_id: params[:order_id])
    render json: @order_items
  end

  def show
    @order_item = OrderItem.find(params[:id])
    render json: @order_item
  end

  def create
    @order_item = OrderItem.save_or_update_from_json(request.body)
    render status: :created, nothing: true, location: order_order_item_url(@order_item.order, @order_item)
    @order_item.order.broadcast("/branches/#{@order_item.order.table.branch.id}/order_items")
  end

  def update
    @order_item = OrderItem.find(params[:id])
    @order_item.update_from_json(request.body)
    render status: :no_content, nothing: true
    @order_item.order.broadcast("/branches/#{@order_item.order.table.branch.id}/order_items")
  end

  def monitor
    respond_to do |format|
      format.html {
        @tables = Table.where(branch_id: params[:branch_id])
      }
      format.json {
        @orders = Order.joins(:table => :branch).where('branches.id' => params[:branch_id])
        render json: @orders
      }
    end
  end

end
