# app/models/user.rb
class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_signature

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_FORMAT }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true,
                                    if: :password_digest_changed?

  def invalidate_auth_tokens
    generate_signature
    save
  end

  private

  def generate_signature
    loop do
      self.auth_signature = SecureRandom.urlsafe_base64
      self.auth_signature_created_at = Time.now
      break unless User.find_by(auth_signature: auth_signature)
    end
  end
end
