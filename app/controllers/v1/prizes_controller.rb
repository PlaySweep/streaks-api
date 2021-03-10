class V1::PrizesController < ApplicationController
  respond_to :json
  
  def index
    @prizes = Prize.all
    respond_with @prizes
  end

  def show
    @prize = Prize.find(params[:id])
    respond_with @prize
  end
end