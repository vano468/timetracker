module Notification
  class NewEmployee
    def after_create_user(user)
      UserMailer.send_password(user, user.password).deliver
    end
  end
end