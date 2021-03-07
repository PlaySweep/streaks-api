class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id, eligible: user.eligible) if user
  end

  private

  attr_accessor :phone_number

  def user
    if user = User.find_by(email: @email)&.authenticate(@password)
      return user
    else
      errors.add(:base, :failure)
    end
    nil
  end
end