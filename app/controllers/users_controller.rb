class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    @user.save!
    session[:id] = @user.id
    redirect_to '/'
  end


  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end

