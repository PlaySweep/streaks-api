class Order < ApplicationRecord
  belongs_to :user
  belongs_to :prize

  scope :for_today, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day, DateTime.current.end_of_day) }
  scope :for_yesterday, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day - 1, DateTime.current.end_of_day - 1) }
  scope :recent, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day - 14, DateTime.current.end_of_day) }

  after_create :deliver_notification, :reset_streak, :update_inventory

  private

  def deliver_notification
    # Send Order Email
  end

  def reset_streak
    user.streak.update_attributes(current: 0)
  end

  def update_inventory
    prize.decrement(:inventory) if prize.inventory > 0
  end

end