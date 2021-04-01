class Streak < ApplicationRecord
  belongs_to :user

  after_update :create_sweep

  private

  def create_sweep
    user.sweeps.create! if saved_change_to_current?(to: 6)
  end
end
