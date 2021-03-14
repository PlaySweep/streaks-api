class WelcomeMailer < ApplicationMailer
  default from: "hi@streakforthebeer.com"

  def notify(user)
    @user = user

    mail(
      to: @user.email,
      subject: "Welcome to Streak for the Beer, #{@user.first_name}!",
      content_type: "text/html"
    )
  end
end