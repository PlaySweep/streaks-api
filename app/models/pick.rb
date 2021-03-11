class Pick < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :user
  belongs_to :matchup
  belongs_to :selection

  enum status: [ :pending, :win, :loss ]

  validates :selection_id, :matchup_id, uniqueness: { scope: :user_id, message: "only 1 per matchup" }

  before_save :is_locked?
  after_save :update_counter_cache
  after_save :update_user_stats

  private

  def is_locked?
    restore_attributes if matchup.round.started? and selection_id_changed?
  end

  def catch_uniqueness_exception
    yield
  rescue ActiveRecord::RecordNotUnique
    self.errors.add(:selection, :taken)
  end

  def update_counter_cache
    card = user.cards.find_by(round_id: matchup.round_id)
    card.update_attributes(picks_won_count: card.picks_won_count += 1) if win?
  end

  def update_user_stats
    user.update_leaderboard_for(:points) if saved_change_to_status?(from: "pending", to: "win")
  end
end
