json.id user[:member]
json.username JSON.parse(user[:member_data])["name"]
json.rank user[:rank].to_i.ordinalize
json.score user[:score]
json.total_members @leaderboard_name.total_members