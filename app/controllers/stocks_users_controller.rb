class StocksUsersController < ApplicationController
  before_action :set_stock_user, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /stock_users
  # GET /stock_users.json
  def index
    @stocks_users = StocksUser.all
  end

  # GET /stock_users/1
  # GET /stock_users/1.json
  def show
    redirect_to industry_path(session[:industry_id])
  end

  # GET /stock_users/new
  def new
    @stocks_user = StocksUser.new
  end

  # GET /stock_users/1/edit
  def edit
  end

  # POST /stock_users
  # POST /stock_users.json
  def create

    if request.xhr?
       @stocks_user = StocksUser.new(stocks_user_params)
       if @stocks_user.save
         render json: "200"
       else
          render json: "500"
       end
    else
      @stocks_user = StocksUser.new(stocks_user_params)
      redirect_to @stock_user
    end


    # respond_to do |format|
    #   if @stock_user.save
    #     format.html { redirect_to @stock_user, notice: 'Stock user was successfully created.' }
    #     format.json { render :show, status: :created, location: @stock_user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @stock_user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /stock_users/1
  # PATCH/PUT /stock_users/1.json
  def update
    respond_to do |format|
      if @stock_user.update(stock_user_params)
        format.html { redirect_to @stock_user, notice: 'Stock user was successfully updated.' }
        format.json { render :show, status: :ok, location: @stock_user }
      else
        format.html { render :edit }
        format.json { render json: @stock_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stock_users/1
  # DELETE /stock_users/1.json
  def destroy
    @stock_user.destroy
    respond_to do |format|
      format.html { redirect_to stock_users_url, notice: 'Stock user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock_user
      @stocks_user = StocksUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stocks_user_params
      params.require(:stock_user).permit(:user_id, :stock_id)
    end
end
