class UserMailer < ApplicationMailer
  def send_password(user, password)
    @user     = user
    @password = password
    mail to: user.email, subject: 'Welcome to TimeTracker'
  end
end