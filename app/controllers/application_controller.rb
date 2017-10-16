class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  protect_from_forgery prepend: true
  before_action :set_user_time_zone

  def authenticate
    redirect_to login_url if session[:user].nil?
  end

  def current_user
    User.find_by_id(session[:user])
  end

  private

  def set_user_time_zone
    Time.zone = current_user.time_zone if is_logged?
  end

  def is_logged?
    session[:user] != nil
  end

end
