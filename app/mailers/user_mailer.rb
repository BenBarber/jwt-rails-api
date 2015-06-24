# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def password_reset(user, token)
    @user = user
    @reset_url = "#{base_url}/?token=#{token}"

    mail(to: @user.email, subject: 'Password reset request')
  end
end
