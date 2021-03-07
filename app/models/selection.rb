class Selection < ApplicationRecord
  belongs_to :matchup

  scope :pending, -> { where(status: 0) }
  scope :winners, -> { where(status: 1) }
  scope :losers, -> { where(status: 2) }
  scope :ordered, -> { order(order: :asc) }

  enum status: [ :pending, :winner, :loser ]
end
