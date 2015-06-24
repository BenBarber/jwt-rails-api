# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def password_reset_preview
    @user = User.new(name: 'Ben')
    UserMailer.password_reset(@user, @user.generate_jwt_reset_token)
  end
end
