class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::Caching

  before_action :authenticate!
  helper_method :current_user

  def authenticate!
    is_authorized = AuthorizeApiRequest.call(request.headers).result
    unless is_authorized
      render json: { error: 'Not Authorized' }, status: 401
    end
  end

  def current_user
    @current_user ||= User.find_by(id: params[:user_id])
  end
end
