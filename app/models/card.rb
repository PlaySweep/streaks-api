class Card < ApplicationRecord
  belongs_to :user
  belongs_to :round

  enum status: [:pending, :win, :loss]

  scope :ordered, -> { order(created_at: :asc) }
  scope :current, -> { joins(:round).merge(Round.active) }

  after_save :update_streak, :update_bonus_stats, :deliver_notification

  private

  def update_streak
    if saved_change_to_status?(from: "pending", to: "win")
      user.streak.update_attributes(current: user.streak.current += 1, previous: user.streak.current, highest: user.streak.highest < user.streak.current ? user.streak.current : user.streak.highest)
    end
    if saved_change_to_status?(from: "pending", to: "loss")
      user.streak.update_attributes(previous: user.streak.current, highest: user.streak.highest < user.streak.current ? user.streak.current : user.streak.highest)
      user.streak.update_attributes(current: 0)
    end
  end

  def deliver_notification
    if saved_change_to_status?(from: "pending", to: "win")
    # DeliverStreakNotificationJob.perform_nowroun
    end
  end

  def update_bonus_stats
    if saved_change_to_bonus?(from: false, to: true)
      current_points = POINTS_LEADERBOARD.score_for(user.id.to_s).to_i || 0
      POINTS_LEADERBOARD.rank_member(user.id.to_s, current_points += 1, { name: user.username }.to_json)
    end
  end

end