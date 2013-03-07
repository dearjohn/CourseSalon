class UserMailer < ActionMailer::Base
  default from: "help@CourseSalon.com"

  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Thank you for Signing up CourseSalon"
  end
end