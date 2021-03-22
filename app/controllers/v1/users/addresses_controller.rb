class V1::Users::AddressesController < ApplicationController
  respond_to :json

  def create
    @address = Address.create(address_params)
    respond_with @address
  end

  def update
    @address = Address.find(params[:id])
    @address.update_attributes(address_params)
    respond_with @address
  end

  private

  def address_params
    params.require(:address).permit(:user_id, :name, :line1, :line2, :city, :state, :zipcode)
  end

end