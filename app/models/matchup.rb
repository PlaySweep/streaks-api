class Matchup < ApplicationRecord
  belongs_to :round
  has_many :selections, dependent: :destroy
  has_many :picks, dependent: :destroy
  has_many :users, through: :picks
  
  enum status: [ :incomplete, :ready, :complete, :closed ]

  scope :ordered, -> { order(order: :asc) }

  after_update :update_picks

  def winner_ids
    selections.winners.map(&:id)
  end

  def loser_ids
    selections.losers.map(&:id)
  end

  private

  def update_picks
    if saved_change_to_status?(from: "ready", to: "complete")
      round = Round.find(self.round_id)
      picks.where(selection_id: winner_ids).map(&:win!)
      picks.where(selection_id: loser_ids).map(&:loss!)
      self.update_columns(status: 3)
      round.ready! if round.matchups.closed.size == round.matchups.size
    end
  end
end
