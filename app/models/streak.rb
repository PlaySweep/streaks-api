class Streak < ApplicationRecord
  belongs_to :user

  after_save :update_user_stats

  private

  def update_user_stats
    if saved_change_to_current?
      current_points = STREAK_LEADERBOARD.score_for(user.id.to_s).to_i || 0
      STREAK_LEADERBOARD.rank_member(user.id.to_s, current_points += 1, { name: user.username }.to_json)
    end
  end
end
