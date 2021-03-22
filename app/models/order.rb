class Order < ApplicationRecord
  belongs_to :user
  belongs_to :prize

  scope :for_today, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day, DateTime.current.end_of_day) }
  scope :for_yesterday, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day - 1, DateTime.current.end_of_day - 1) }
  scope :recent, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day - 14, DateTime.current.end_of_day) }

  after_create :deliver_notification, :reset_streak, :update_inventory

  private

  def deliver_notification
    OrderMailer.notify(self).deliver_now
  end

  def reset_streak
    new_streak = user.streak.current -= prize.level
    STREAK_LEADERBOARD.rank_member(user.id.to_s, new_streak, { name: user.username }.to_json)
    user.streak.update_attributes(current: new_streak)
  end

  def update_inventory
    prize.decrement(:inventory) if prize.inventory > 0
  end

end