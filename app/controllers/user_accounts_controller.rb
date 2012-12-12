class UserAccountsController < ApplicationController
  def new
    @user_account = UserAccount.new
  end

  def create
    @user_account = UserAccount.new(params[:user_account])
    if @user_account.save
      redirect_to root_path,
                  notice: "Your user account has been created!"
    else
      render "new"
    end
  end
end
