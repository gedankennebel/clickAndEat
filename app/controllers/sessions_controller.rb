class SessionsController < ApplicationController
  def new
  end

  def create
    user_account = UserAccount.find_by_email(params[:email])
    if user_account && user_account.authenticate(params[:password])
      reset_session
      session[:user_account_id] = user_account
      redirect_to root_path, notice: "You are logged in"
    else
      flash.now.alert = "Wrong email or password!"
      render "new"
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "You are logged out"
  end
end
