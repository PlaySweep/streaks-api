class ResultsJob < ApplicationJob
  queue_as :critical

  def perform user_id, card_id
    user = User.find_by(id: user_id)
    card = Card.find_by(id: card_id)
    ResultsMailer.notify(user, card).deliver_later
  end
end