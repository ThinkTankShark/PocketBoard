class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    @user = User.new(user_params)
    p @user
    if @user.save
      redirect_to 'pages#home'
      p "GOOD"
    else
      p "ERROR"
    end

  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end

