class HoldingsController < ApplicationController
  def create
    @holding = Holding.new(holding_params)
    debugger
    respond_to do |format|
      if @holding.save
        format.html { redirect_to @holding, notice: 'Holding was successfully created.' }
        format.json { render :show, status: :created, location: @holding }
      else
        format.html { render :new }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def holding_params
      params.require(:holding).permit(:symbol, :allocation)
    end
end

