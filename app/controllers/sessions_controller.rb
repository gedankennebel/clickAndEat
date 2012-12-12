class SessionsController < ApplicationController
  def new
  end

  def create
    user_account = UserAccount.find_by_email(params[:email])
    if user_account && user_account.authenticate(params[:password])
      session[:user_account_id] = user_account_id
      redirect_to root_path, notice: "You are logged in"
    else
      flash.now.alert = "Wrong email or password!"
      render "new"
    end
  end

  def destroy
    session[:user_account_id] = nil
    redirect_to root_path, notice: "You are logged out"
  end
end