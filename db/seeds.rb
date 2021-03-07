account = Account.find(1)
round = Round.find_or_create_by(
  name: "First Four", 
  account_id: account.id, 
  start_time: DateTime.current + 1.day, 
  end_time: DateTime.current + 2.days
)

matchup1 = Matchup.find_or_create_by(description: "Duke win vs UNC win", order: 1)
matchup2 = Matchup.find_or_create_by(description: "Overall points scored today", order: 2)
matchup3 = Matchup.find_or_create_by(description: "OSU win vs. University of Michigan", order: 3)
matchup4 = Matchup.find_or_create_by(description: "Will there be an overtime game?", order: 4)
matchup5 = Matchup.find_or_create_by(description: "Will Oregon score more than 63 points?", order: 5)


matchup1.selections.find_or_create_by(description: "Duke", order: 1)
matchup1.selections.find_or_create_by(description: "UNC", order: 2)

matchup2.selections.find_or_create_by(description: "1000 points or less", order: 1)
matchup2.selections.find_or_create_by(description: "Over 1000 points", order: 2)

matchup3.selections.find_or_create_by(description: "OSU wins", order: 1)
matchup3.selections.find_or_create_by(description: "University of Michigan", order: 2)

matchup4.selections.find_or_create_by(description: "Yes", order: 1)
matchup4.selections.find_or_create_by(description: "No", order: 2)

matchup5.selections.find_or_create_by(description: "Yes", order: 1)
matchup5.selections.find_or_create_by(description: "No", order: 2)

# Make picks
user = User.first
user.picks.find_or_create_by(matchup_id: matchup1.id, selection_id: matchup1.selections.sample.id)
user.picks.find_or_create_by(matchup_id: matchup2.id, selection_id: matchup2.selections.sample.id)
user.picks.find_or_create_by(matchup_id: matchup3.id, selection_id: matchup3.selections.sample.id)
user.picks.find_or_create_by(matchup_id: matchup4.id, selection_id: matchup4.selections.sample.id)
user.picks.find_or_create_by(matchup_id: matchup5.id, selection_id: matchup5.selections.sample.id)

# Prizing
prize1 = Prize.find_or_create_by(name: "$5 Drizly Credit", description: "Streak Cashout", level: 1)
prize2 = Prize.find_or_create_by(name: "Bud Light Hat", description: "Streak Cashout", level: 1)
prize3 = Prize.find_or_create_by(name: "Bud Light Koozie", description: "Streak Cashout", level: 1)

reward1 = user.rewards.find_or_create_by(prize_id: prize2.id)