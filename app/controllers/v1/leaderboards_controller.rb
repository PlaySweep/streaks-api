class V1::LeaderboardsController < ApplicationController
  respond_to :json
  
  def index
    @leaderboard_name = "#{params[:type].upcase}_LEADERBOARD".constantize
    page = params[:page] || 1
    page_size = params[:page_size] || 5
    @users = @leaderboard_name.leaders(page.to_i, page_size: page_size.to_i, with_member_data: true)
    respond_with @users
  end
end