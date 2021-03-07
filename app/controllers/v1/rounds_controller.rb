class V1::RoundsController < ApplicationController
  respond_to :json
  
  def index
    @rounds = Round.all
    respond_with @rounds
  end

  def show
    @round = Round.find(params[:id])
    respond_with @round
  end
end