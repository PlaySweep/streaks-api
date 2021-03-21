class WelcomeJob < ApplicationJob
  queue_as :critical

  def perform user_id
    user = User.find_by(id: user_id)
    WelcomeMailer.notify(user).deliver_later
  end
end