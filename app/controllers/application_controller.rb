class ApplicationController < ActionController::Base
  private

  def require_signin
    return if current_user

    session[:intended_url] = request.url
    redirect_to new_session_url, alert: 'Only signed users can do this'
  end

  def require_admin
    redirect_to :root, alert: 'Unauthorized access.' unless current_user_admin?
  end

  def current_user_admin?
    current_user&.admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?
  helper_method :current_user_admin?
  helper_method :current_user
end
