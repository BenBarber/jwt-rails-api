require 'bcrypt'

# Password helper for use in fixtures
module TestPasswordHelper
  def default_password_digest
    BCrypt::Password.create(default_password, cost: 4)
  end

  def default_password
    'password'
  end
end
