class V1::Users::CardsController < ApplicationController
  respond_to :json
  
  def index
    @cards = Card.where(user_id: params[:user_id]).ordered
    respond_with @cards
  end

end