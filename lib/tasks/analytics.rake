def send_email cards
  cards.each_with_index do |card, index|
    ResultsJob.perform_later(card.user_id, card.id)
    sleep 5 if index % 10 == 0
  end
end