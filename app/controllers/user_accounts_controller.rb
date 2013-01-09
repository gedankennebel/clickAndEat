class UserAccountsController < ApplicationController
  before_filter :require_login
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user_account = UserAccount.new
  end

  def create
    @user_account = UserAccount.new params[:user_account]
    # set default role for new created user account
    @user_account.roles =
        Role.find_all_by_name 'user'
    if @user_account.save
      redirect_to login_path,
                  notice: "Your user account has been created!"
    else
      render "new"
    end
  end

  def save_filter_definition
    current_user.filter_definition.from_json(request.body).save!
    render status: :no_content, nothing: true
  end

  def get_filter_definition
    render json: current_user.filter_definition
  end

  def index
    @user_account = current_user
  end

  def join_restaurant
  end

  def apply_to_restaurant_as_employee
    if UserAccount.send_employee_request_to_manager current_user, params[:restaurant_name]
      redirect_to user_account_path,
                  notice: 'Sent request to the manager of restaurant ' + params[:restaurant_name]
    else
      redirect_to user_accounts_path,
                  alert: 'Restarant with name '+ params[:restaurant_name] + ' not found'
    end
  end

  def accept_employee
    UserAccount.accept_employee params[:message_id]
    redirect_to messages_path
  end

  def decline_employee
    UserAccount.decline_employee params[:message_id]
    redirect_to messages_path
  end

end
