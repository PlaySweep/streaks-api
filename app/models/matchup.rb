class Matchup < ApplicationRecord
  belongs_to :round
  has_many :selections, dependent: :destroy
  has_many :picks, dependent: :destroy
  has_many :users, through: :picks
  
  enum status: [ :incomplete, :ready, :complete, :closed ]

  scope :ordered, -> { order(order: :asc) }

  after_update :update_picks

  private

  def update_picks
    round = Slate.find(self.round_id)
    self.picks.where(selection_id: self.winner_ids).map(&:win!)
    self.picks.where(selection_id: self.loser_ids).map(&:loss!)
    self.update_columns(status: 3)
    round.ready! if round.matchups.closed.size == round.matchups.size
  end
end
