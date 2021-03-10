class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::Caching

  before_action :authenticate!
  helper_method :current_user

  def authenticate!
    authorized_user = AuthorizeApiRequest.call(request.headers).result
    if authorized_user
      session[:current_user_id] = authorized_user.id
    else
      render json: { error: 'Not Authorized' }, status: 401
    end
  end

  private

  def current_user
    @current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end
end
