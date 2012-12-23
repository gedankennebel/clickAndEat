class UserAccountsController < ApplicationController

  def index
    @user_account = current_user
  end

  def save_filter_definition
    current_user.filter_definition.from_json(request.body).save!
    render status: :no_content, nothing: true
  end

  def get_filter_definition
    render json: current_user.filter_definition
  end

  def new
    @user_account = UserAccount.new
  end

  def create
    @user_account = UserAccount.new(params[:user_account])
    # set default role for new created user account
    @user_account.roles = Role.find_all_by_name "user"
    if @user_account.save
      redirect_to root_path,
                  notice: "Your user account has been created!"
    else
      render "new"
    end
  end
end
