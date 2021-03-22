json.id order.id
json.user order.user, partial: 'v1/users/user', as: :user
json.prize order.prize, partial: 'v1/prizes/prize', as: :prize
json.size order.size