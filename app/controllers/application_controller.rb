class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  # Get current user
  def current_user
    if session[:user_id]
      return @current_user ||= UserAccount.find(session[:user_id])
    end
  end

  def user_signed_id?
    return current_user.present?
  end

  helper_method :user_signed_id?
end
