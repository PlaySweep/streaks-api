class Card < ApplicationRecord
  belongs_to :user
  belongs_to :round

  enum status: [:pending, :win, :loss]

  scope :ordered, -> { order(created_at: :asc) }
  scope :current, -> { joins(:round).merge(Round.active) }

  validates :round_id, uniqueness: { scope: :user_id, message: "only 1 Card per Entry" }

  around_save :catch_uniqueness_exception
  after_save :update_streak, :increment_bonus_stats, :decrement_bonus_stats, :deliver_notification

  private

  def catch_uniqueness_exception
    yield
  rescue ActiveRecord::RecordNotUnique
    self.errors.add(:round_id, :taken)
  end

  def update_streak
    if saved_change_to_status?(from: "pending", to: "win")
      STREAK_LEADERBOARD.rank_member(user.id.to_s, user.streak.current += 1, { name: user.username }.to_json)
      user.streak.update_attributes(current: user.streak.current += 1, previous: user.streak.current, highest: user.streak.highest < user.streak.current ? user.streak.current : user.streak.highest)
    end
    if saved_change_to_status?(from: "pending", to: "loss")
      user.streak.update_attributes(previous: user.streak.current, highest: user.streak.highest < user.streak.current ? user.streak.current : user.streak.highest)
      STREAK_LEADERBOARD.rank_member(user.id.to_s, 0, { name: user.username }.to_json)
      user.streak.update_attributes(current: 0)
    end
  end

  def deliver_notification
    if saved_change_to_status?(from: "pending", to: "win")
    # DeliverStreakNotificationJob.perform_nowroun
    end
  end

  def increment_bonus_stats
    if saved_change_to_bonus?(from: false, to: true)
      current_points = POINTS_LEADERBOARD.score_for(user.id.to_s).to_i || 0
      POINTS_LEADERBOARD.rank_member(user.id.to_s, current_points += 1, { name: user.username }.to_json)
    end
  end

  def decrement_bonus_stats
    if saved_change_to_bonus?(from: true, to: false)
      current_points = POINTS_LEADERBOARD.score_for(user.id.to_s).to_i || 0
      POINTS_LEADERBOARD.rank_member(user.id.to_s, current_points -= 1, { name: user.username }.to_json)
    end
  end

end