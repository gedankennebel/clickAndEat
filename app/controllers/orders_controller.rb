class OrdersController < ApplicationController
  # GET /orders
  def index
    @orders = Order.where(closed: false)
  end

  # GET /orders/1
  def show
    @order = Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  # def edit
  #   @order = Order.find(params[:id])
  # end

  # POST /orders
  def create
    @order = Order.new(params[:order])
    @order.closed=0
    #@order.save
    if @order.save
      redirect_to(@order, :notice => 'Order was successfully created.')
    else
    render :action => "new"
    end
  end

  # PUT /orders/1
  # def update
  #   @order = Order.find(params[:id])
  #   respond_to do |format|
  #   if @order.update_attributes(params[:order])
  #     redirect_to(@order, :notice => 'Order was successfully updated.')
  #   else
  #     render :action => "edit"
  #   end
  # end

  # DELETE /orders/1
  # def destroy
  #   @order = Order.find(params[:id])
  #   @order.destroy
  #   redirect_to(orders_url)
  # end
end
