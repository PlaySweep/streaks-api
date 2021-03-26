class ResultsMailer < ApplicationMailer
  default from: "streaks@streakforthebeer.com"

  def notify(user, card)
    @user = user
    @card = card

    if @card.win?
      mail(
      to: @user.email,
      subject: "Congrats #{@user.first_name}, you hit a streak!",
      content_type: "text/html"
    )
    else
      mail(
      to: @user.email,
      subject: "Here are your #{@card.round.name} results, #{@user.first_name}!",
      content_type: "text/html"
    )
    end
  end

  def reminder(user)
    @user = user
  
    mail(
      from: "streaks@streakforthebeer.com",
      to: @user.email,
      subject: "🏀 Make your picks for Round 3!",
      content_type: "text/html"
    )
  end
end