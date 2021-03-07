class AuthController < ApplicationController 
  skip_before_action :authenticate!

  def authenticate
    command = AuthenticateUser.call(login_params[:email], login_params[:password])
 
    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { auth_token: nil }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end