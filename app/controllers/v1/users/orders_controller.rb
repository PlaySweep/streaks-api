class V1::Users::OrdersController < ApplicationController
  respond_to :json

  def create
    @order = Order.create(order_params)
    respond_with @order
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :prize_id, :email)
  end

end