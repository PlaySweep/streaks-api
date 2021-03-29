def send_email cards
  cards.each_with_index do |card, index|
    ResultsJob.perform_later(card.user_id, card.id)
    sleep 5 if index % 500 == 0
  end
end

def send_reminder_email users
  users.each_with_index do |user, index|
    ResultsMailer.reminder(user).deliver_later
    sleep 5 if index % 500 == 0
  end
end