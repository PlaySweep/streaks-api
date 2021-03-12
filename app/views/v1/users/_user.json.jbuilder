json.id user.id
json.username user.username
json.first_name user.first_name
json.last_name user.last_name
json.referral_code user.referral_code
json.dob user.dob
json.played_cards user.cards.ordered, partial: 'v1/users/cards/card', as: :card
json.streak user.streak.current
json.points user.cards.sum(:picks_won_count)
json.streak_rank STREAK_LEADERBOARD.total_members > 0 ? STREAK_LEADERBOARD.rank_for(user.id.to_s) : 0
json.points_rank POINTS_LEADERBOARD.total_members > 0 ? POINTS_LEADERBOARD.rank_for(user.id.to_s) : 0