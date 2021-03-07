class Round < ApplicationRecord
  WINNING_THRESHOLD = 3
  belongs_to :account
  has_many :matchups, dependent: :destroy
  has_many :selections, through: :matchups
  has_many :users, -> { distinct }, through: :matchups
  has_many :picks, -> { distinct }, through: :users

  enum status: [ :inactive, :pending, :started, :ready, :complete, :done, :postponed, :deactivated ]

  after_save :settle_results

  def winners
    selections.winners
  end

  private

  def settle_results
    users.each do |user|
      if saved_change_to_status?(from: 'ready', to: 'complete')
        streak = Streak.find_or_create_by(user_id: user_id)
        if user.won_round?(self)
          user.rewards.create!
          streak.update_attributes(previous: streak.current, current: streak.current += 1) 
          streak.update_attributes(highest: streak.current) if streak.highest < streak.current
        else
          streak.update_attributes(previous: streak.current, current: 0) 
        end
      end
    end
  end
end
