class Selection < ApplicationRecord
  belongs_to :matchup

  scope :pending, -> { where(status: 0) }
  scope :winners, -> { where(status: 1) }
  scope :losers, -> { where(status: 2) }
  scope :ordered, -> { order(order: :asc) }

  enum status: [ :pending, :winner, :loser ]

  scope :ordered, -> { order(order: :asc) }

  after_update :check_associated_matchup_status

  def selected current_user
    id == current_user.picks.where(matchup_id: matchup_id).where(selection_id: id).try(:first).try(:selection_id)
  end

  private

  def check_associated_matchup_status
    if matchup.selections.pending.empty?
      self.matchup.ready!
    else
      self.matchup.incomplete! unless event.incomplete?
    end
  end

end
