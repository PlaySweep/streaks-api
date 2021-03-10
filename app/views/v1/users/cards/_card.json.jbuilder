json.id card.id
json.round card.round, partial: 'v1/rounds/round', as: :round
json.status card.status
json.score card.picks_won_count