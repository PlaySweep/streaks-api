class V1::Users::PicksController < ApplicationController
  respond_to :json
  
  def index
    @picks = Pick.where(user_id: params[:user_id])
    respond_with @picks
  end

  def create
    @pick = Pick.create(pick_params)
    respond_with @pick
  end

  private

  def pick_params
    params.require(:pick).permit(:user_id, :matchup_id, :selection_id)
  end

end