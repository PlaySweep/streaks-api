json.id round.id
json.name round.name
json.matchups round.matchups.ordered, partial: 'v1/matchups/matchup', as: :matchup
json.status round.status
json.start_time round.start_time
json.end_time round.end_time