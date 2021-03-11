class Order < ApplicationRecord
  belongs_to :user
  belongs_to :prize

  scope :for_today, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day, DateTime.current.end_of_day) }
  scope :for_yesterday, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day - 1, DateTime.current.end_of_day - 1) }
  scope :recent, -> { where('created_at BETWEEN ? AND ?', DateTime.current.beginning_of_day - 14, DateTime.current.end_of_day) }

  after_create :deliver_notification

  private

  def deliver_notification
    # Send Order Email
  end

end