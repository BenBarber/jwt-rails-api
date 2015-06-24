# app/models/user.rb
class User < ActiveRecord::Base
  has_secure_password
  has_secure_token :auth_token

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_FORMAT }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true,
                                    if: :password_digest_changed?

  def generate_jwt_auth_token
    regenerate_auth_token
    JsonWebToken.generate_token(self, :auth, 24.hours.from_now)
  end

  def generate_jwt_reset_token
    update_attributes(reset_token: SecureRandom.base58(24),
                      reset_token_expires: 24.hours.from_now)
    JsonWebToken.generate_token(self, :reset, 12.hours.from_now)
  end
end
