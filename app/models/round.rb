class Round < ApplicationRecord
  WINNING_THRESHOLD = 3
  belongs_to :account
  has_many :matchups, dependent: :destroy
  has_many :cards
  has_many :selections, through: :matchups, dependent: :destroy
  has_many :users, -> { distinct }, through: :matchups
  has_many :picks, -> { distinct }, through: :users

  enum status: [ :inactive, :pending, :started, :ready, :complete, :done, :postponed, :deactivated ]

  scope :ordered, -> { order(start_time: :asc) }
  scope :active, -> { where(status: [1, 2, 3])}
  
  after_save :settle_results
  after_update :set_next_round_status

  def winners
    selections.winners
  end

  private

  def settle_results
    users.each do |user|
      if saved_change_to_status?(from: 'ready', to: 'complete')
        if user.won_round?(self)
          user.cards.find_by(round_id: id).win!
        else
          user.cards.find_by(round_id: id).loss!
        end
      end
    end
  end

  def set_next_round_status
    Round.inactive.ordered.first.pending! if saved_change_to_status?(from: "complete", to: "done")
  end
end
