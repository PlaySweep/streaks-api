class User < ApplicationRecord
  has_secure_password

  belongs_to :account
  has_one :address, dependent: :destroy
  has_one :streak, dependent: :destroy
  has_many :picks
  has_many :rewards
  has_many :cards

  before_create :set_referral_code
  after_create :add_streak_record

  def won_round? current_round
    current_round.matchups.pluck(:id)
    winning_picks = picks.where(matchup_id: current_round.matchups.pluck(:id), status: 1)
    winning_picks.size >= Round::WINNING_THRESHOLD
  end

  def update_leaderboard_for type
    STREAK_LEADERBOARD.rank_member(id.to_s, streak.current, { name: username }.to_json) if type == :streak
    POINTS_LEADERBOARD.rank_member(id.to_s, picks.win.size, { name: username }.to_json) if type == :points
  end

  def rank
    STREAK_LEADERBOARD.rank_for(id.to_s)
  end

  private

  def add_streak_record
    Streak.find_or_create_by(user_id: id)
  end

  def set_referral_code
    self.referral_code = "#{self.username}#{SecureRandom.hex(2)}" if self.username
  end

end
