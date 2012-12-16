class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :set_vary_header


  private
  def set_vary_header
    response.headers['Vary'] = 'Accept-Encoding, Accept'
  end

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
