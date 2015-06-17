# app/models/user.rb
class User < ActiveRecord::Base
  has_secure_password
  before_create :generate_token_signiture

  EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_FORMAT }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true,
                                    if: :password_digest_changed?

  def update_token
    generate_token_signiture
  end

  private

  def generate_token_signiture
    loop do
      self.token_signiture = SecureRandom.urlsafe_base64
      break unless User.find_by(token_signiture: token_signiture)
    end
  end
end
