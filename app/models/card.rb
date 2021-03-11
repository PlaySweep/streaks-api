class Card < ApplicationRecord
  belongs_to :user
  belongs_to :round

  enum status: [:pending, :win, :loss]

  scope :ordered, -> { order(created_at: :asc) }

  after_save :update_streak, :deliver_notification

  private

  def update_streak
    if saved_change_to_picks_won_count?
      if picks_won_count == 3
        streak = user.streak
        if streak.nil?
          user.create_streak(current: 1, highest: 1, previous: 0)
        else
          streak.update_attributes(current: streak.current += 1, previous: streak.current, highest: streak.highest < streak.current ? streak.current : streak.highest)
        end
      end
    end
  end

  def deliver_notification
    if saved_change_to_picks_won_count?
      if picks_won_count == 3
        # DeliverStreakNotificationJob.perform_now
      end
    end
  end
end