class OrdersController < ApplicationController
  before_filter :require_login

  def index
    unless current_user.branch.nil?
      branch_id = params[:branch_id]
      @order = Order.new
      unless current_user.branch_id.eql? branch_id
        branch_id = current_user.branch_id
      end
      @tables = Table.where(branch_id: branch_id)
      @orders = Order.where(table_id: @tables.map(&:id), closed: false)
    else
      redirect_to user_accounts_path
    end
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
      redirect_to(branch_order_url(params[:branch_id], @order))
      @order.broadcast("/branches/#{params[:branch_id]}/order_items")
    else
      render :action => "show"
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.from_json(request.body)
    @order.save!
    render status: :no_content, nothing: true
    Order.find(params[:id]).broadcast("/branches/#{params[:branch_id]}/order_items")
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    render status: :no_content, nothing: true
  end

end
