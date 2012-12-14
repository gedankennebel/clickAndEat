class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  # Get current user
  def current_user
    if session[:user_account_id]
      @current_user ||= UserAccount.find(session[:user_account_id])
    end
  end

  def user_signed_id?
    current_user.present?
  end

  helper_method :user_signed_id?
  helper_method :current_user
end
