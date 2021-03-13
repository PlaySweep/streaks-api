class Matchup < ApplicationRecord
  belongs_to :round
  has_many :selections, dependent: :destroy
  has_many :picks, dependent: :destroy
  has_many :users, through: :picks
  
  enum status: [ :incomplete, :ready, :complete, :closed ]

  scope :ordered, -> { order(order: :asc) }
end
