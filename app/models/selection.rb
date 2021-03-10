class Selection < ApplicationRecord
  belongs_to :matchup

  scope :pending, -> { where(status: 0) }
  scope :winners, -> { where(status: 1) }
  scope :losers, -> { where(status: 2) }
  scope :ordered, -> { order(order: :asc) }

  enum status: [ :pending, :winner, :loser ]

  scope :ordered, -> { order(order: :asc) }

  def selected current_user
    id == current_user.picks.where(matchup_id: matchup_id).where(selection_id: id).try(:first).try(:selection_id)
  end
end
