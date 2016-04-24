class PageController < ApplicationController
  def home
    @user = User.new
  end
end
