json.id user.id
json.first_name user.first_name
json.last_name user.last_name
json.played_cards user.cards.ordered, partial: 'v1/users/cards/card', as: :card