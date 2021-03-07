class V1::PicksController < ApplicationController
  respond_to :json
  
  def show
    pick = Pick.find(params[:id])
    render json: pick, status: :ok
  end
end