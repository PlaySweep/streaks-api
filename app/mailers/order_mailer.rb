class OrderMailer < ApplicationMailer
  default from: "hi@streakforthebeer.com"

  def notify(order)
    @order = order

    mail(
      to: @order.email,
      subject: "✅ You successfully Cashed Out, #{@order.user.first_name}!",
      content_type: "text/html"
    )
  end
end