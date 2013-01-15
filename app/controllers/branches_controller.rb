class BranchesController < ApplicationController
  before_filter :require_login

  def show
    @branch = Branch.find(params[:id])
    render json: @branch
  end

  def new
    @branch = Branch.new
    @address = Address.new
  end

  def create
    @address = Address.new_adress params[:street], params[:number], params[:city], params[:postcode]
    if @address.save
      @branch = Branch.create_new_branch current_user.restaurant, params[:branch]
      @branch.address = @address
      current_user.restaurant.branches << @branch
      if @branch.save
        current_user.restaurant.save!
        Table.create_branch_tables params[:tables_amount], @branch.id
        redirect_to user_accounts_path, notice: 'Your branch has been created!'
      else
        @address = Address.new
        render 'new'
      end
    else
      @branch = Branch.new
      render 'new'
    end

  end
end
