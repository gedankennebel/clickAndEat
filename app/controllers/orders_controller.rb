class OrdersController < ApplicationController
  # GET /orders
  def index
    @orders = Order.where(closed: false)
  end

  # GET /orders/1
  def show
    respond_to do |format|
      format.html
      format.json {
        @order = Order.find(params[:id])
        render json: @order
      }
    end
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

  #PUT /orders/1
  def update
    @order = Order.new.from_json(request.body)
    @order.update_attributes(params[:order])
  end

  # DELETE /orders/1
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    render status: :no_content
  end
end
