class UserMailer < ActionMailer::Base
  default from: "admin@taskrpg.com"

  def password_reset(user)
  	@user = user
  	@new_password = user.password.to_s
  	mail(to: @user.email, subject: 'Password Reset')
  end
end
