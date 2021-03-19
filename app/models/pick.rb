class Pick < ApplicationRecord
  include ActiveModel::Dirty

  belongs_to :user
  belongs_to :matchup
  belongs_to :selection

  enum status: [ :pending, :win, :loss ]

  validates :selection_id, :matchup_id, uniqueness: { scope: :user_id, message: "only 1 per matchup" }

  before_save :is_locked?
  after_save :update_counter_cache

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
    card = user.cards.find_or_create_by(round_id: matchup.round_id)
    if win?
      card.update_attributes(picks_won_count: card.picks_won_count += 1)
      current_points = user.cards.sum(:picks_won_count)
      POINTS_LEADERBOARD.rank_member(user_id.to_s, current_points += 1, { name: user.username }.to_json)
    end
  end
end
