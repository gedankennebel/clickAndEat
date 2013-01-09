class BranchesController < ApplicationController
  def show
    @branch = Branch.find(params[:id])
    render json: @branch
  end

  def new
    @branch = Branch.new
    @address = Address.new
  end

  def create
    @branch = Branch.create_new_branch current_user.restaurant, params[:branch], params[:street], params[:number], params[:city], params[:postcode]
    if @branch.save
      Table.create_branch_tables params[:tables_amount], @branch.id
      redirect_to user_accounts_path, notice: 'Your branch has been created!'
    else
      render "new"
    end
  end
end
