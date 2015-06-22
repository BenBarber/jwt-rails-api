# app/models/user.rb
class User < ActiveRecord::Base
  has_secure_password
  before_create generate_signature: :auth

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_FORMAT }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true,
                                    if: :password_digest_changed?

  def invalidate_auth_tokens
    generate_signature :auth
  end

  private

  def generate_signature(sub)
    loop do
      send "#{sub}_signature=", SecureRandom.urlsafe_base64
      send "#{sub}_signature_created_at=", Time.zone.now
      break unless User.find_by("#{sub}_signature",
                                send("#{sub}_signature"))
    end
  end
end
