class CreateNewUser
  extend LightService::Organizer

  def self.call(user, params)
    with(user: @user, params: params).reduce(
      ChecksForReferral,
      SendWelcomeMessage
    )
  end
end

class ChecksForReferral
  extend ::LightService::Action
  expects :user, :params

  executed do |context|
    unless context.params[:ref].nil?
      referred_by = User.find_by(ref: context.params[:ref])
      context.user.referred_by_id = referred_by.id unless referred_by.nil?
      context.user.save
    end
  end
end

class SendWelcomeMessage
  extend LightService::Action
  expects :user

  executed do |context|
    if context.user
      WelcomeMailer.notify(context.user).deliver_later
      context.user.save
    end
  end
end