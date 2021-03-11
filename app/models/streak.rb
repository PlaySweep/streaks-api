class Streak < ApplicationRecord
  belongs_to :user

  after_save :update_user_stats

  private

  def update_user_stats
    user.update_leaderboard_for(:streak)
  end
end
