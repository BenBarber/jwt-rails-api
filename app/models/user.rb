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
    save
  end

  private

  def generate_signature(resource)
    loop do
      send "#{resource}_signature=", SecureRandom.urlsafe_base64
      send "#{resource}_signature_created_at=", Time.zone.now
      break unless User.find_by("#{resource}_signature",
                                send("#{resource}_signature"))
    end
  end
end
