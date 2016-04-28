module ApplicationHelper
  def user_signed_in?
    if session[:id].nil?
      return false
    else
      return true
    end
  end

  def current_user
    return unless session[:id]
    @current_user ||= User.find(session[:id])
  end
end
