class V1::Users::CardsController < ApplicationController
  respond_to :json
  
  def index
    @cards = Card.where(user_id: params[:user_id]).ordered
    respond_with @cards
  end

  def create
    @card = Card.create(card_params)
    respond_with @card
  end

  private

  def card_params
    params.require(:card).permit(:user_id, :round_id)
  end

end