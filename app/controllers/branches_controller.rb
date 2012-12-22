class BranchesController < ApplicationController
  def show
    @branch = Branch.find(params[:id])
    render json: @branch
  end
end