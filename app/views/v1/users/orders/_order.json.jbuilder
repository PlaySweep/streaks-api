json.id order.id
json.user order.user, partial: 'v1/users/user', as: :user
json.prize_id order.prize_id