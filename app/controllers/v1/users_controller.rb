class V1::UsersController < ApplicationController
  respond_to :json
  skip_before_action :authenticate!, only: [ :create ]
  
  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def create
    @user = User.new(user_params)

    # Set referral id present
    referred_by = User.find_by(referral_code: params["ref"]) if params["ref"]
    @user.referred_by_id = referred_by.id unless referred_by.nil?

    if @user.save
      WelcomeMailer.notify(@user).deliver_later
      token = JsonWebToken.encode(user_id: @user.id)
      render json: {user: @user, token: token}
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
  end

  private

  def user_params
    params.permit(:username, :first_name, :last_name, :dob, :email, :password, :account_id, :referred_by_id, address_attributes: [:line1, :line2, :city, :state, :zipcode])
  end

end