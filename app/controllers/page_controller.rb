class PageController < ApplicationController
  def home
    if user_signed_in?
      @user = User.find(session[:id])
      @portfolios = @user.portfolios
    end
  end
end
