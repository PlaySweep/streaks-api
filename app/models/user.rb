class User < ApplicationRecord
  has_secure_password

  belongs_to :account
  belongs_to :referred_by, class_name: "User", optional: true
  has_one :address, dependent: :destroy
  has_one :streak, dependent: :destroy
  has_many :picks
  has_many :rewards
  has_many :cards

  accepts_nested_attributes_for :address

  before_create :set_referral_code, :check_for_referral
  after_create :add_streak_record

  def won_round? card_for_round
    won_by_bonus?(card_for_round) || won_by_picks?(card_for_round)
  end

  def won_by_bonus? card_for_round
    (card_for_round.picks_won_count >= Round::BONUS_THRESHOLD) && card_for_round.bonus?
  end

  def won_by_picks? card_for_round
    card_for_round.picks_won_count >= Round::WINNING_THRESHOLD
  end

  def update_leaderboard_for type
    STREAK_LEADERBOARD.rank_member(id.to_s, streak.current, { name: username }.to_json) if type == :streak
    POINTS_LEADERBOARD.rank_member(id.to_s, picks.win.size, { name: username }.to_json) if type == :points
  end

  def streak_rank
    STREAK_LEADERBOARD.rank_for(id.to_s) || 0
  end

  def points_rank
    POINTS_LEADERBOARD.rank_for(id.to_s) || 0
  end

  def current_card
    cards.current.last
  end

  def played?
    cards.current.any?
  end

  private

  def check_for_referral
    if self.referred_by_id?
      self.referred_by.current_card.update_attributes(bonus: true) unless self.referred_by.current_card.nil?
    end
  end

  def add_streak_record
    Streak.find_or_create_by(user_id: id)
  end

  def set_referral_code
    self.referral_code = "#{self.username}#{SecureRandom.hex(2)}" if self.username
  end

end
