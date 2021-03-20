json.id user.id
json.username user.username
json.first_name user.first_name
json.last_name user.last_name
json.email user.email
json.referral_code user.referral_code
json.dob user.dob
json.played_cards user.cards.ordered, partial: 'v1/users/cards/card', as: :card
json.streak_score STREAK_LEADERBOARD.score_for(user.id.to_s) || 0
json.points_score POINTS_LEADERBOARD.score_for(user.id.to_s) || 0
json.played user.played?
json.streak_rank STREAK_LEADERBOARD.total_members > 0 ? user.streak_rank : 0
json.points_rank POINTS_LEADERBOARD.total_members > 0 ? user.points_rank : 0