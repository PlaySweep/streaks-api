json.id matchup.id
json.round_id matchup.round_id
json.order matchup.order
json.description matchup.description
json.status matchup.status
json.selections matchup.selections.ordered, partial: 'v1/selections/selection', as: :selection