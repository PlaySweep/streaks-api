class V1::UsersController < ApplicationController
  respond_to :json
  skip_before_action :authenticate!, only: [ :create ]
  
  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def create
    user = User.create(user_params)
    if user.valid?
      token = JsonWebToken.encode(user_id: user.id, eligible: user.eligible)
      render json: {user: user, token: token}
    else
      render json: {errors: user.errors.full_messages}
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
    params.permit(:username, :first_name, :last_name, :dob, :email, :password, :account_id)
  end

end