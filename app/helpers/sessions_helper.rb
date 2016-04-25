module SessionsHelper
  def user_signed_in?
    if session[:id].nil?
      return false
    else
      return true
    end
  end
end
