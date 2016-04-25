class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user.password == params[:password]
      session[:id] = @user.id
      redirect_to '/'
    else
      redirect_to '/'
    end
  end

  def destroy
    session[:id] = nil
    redirect_to '/'
  end
end
