class OrdersController < ApplicationController
  def index
    @order = Order.new
    @tables = Table.where(branch_id: params[:branch_id])
    @orders = Order.where(table_id: @tables.map(&:id), closed: false)
  end

  def show
    respond_to do |format|
      format.html
      format.json {
        @order = Order.find(params[:id])
        render json: @order
      }
    end
  end

  def create
    @order = Order.new(params[:order])
    @order.closed=0
    #@order.save
    if @order.save
      redirect_to(@order, :notice => 'Order was successfully created.')
    else
      render :action => "show"
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.from_json(request.body)
    @order.save!
    broadcast("/branches/#{params[:branch_id]}/orders", @order)
    render status: :no_content, nothing: true
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    render status: :no_content, nothing: true
  end

  private
  def broadcast(channel, data)
    message = {:channel => channel, :data => data, :ext => {:auth_token => FAYE_TOKEN}}.to_json
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message)
  end
end
