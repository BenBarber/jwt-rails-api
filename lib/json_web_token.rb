# lib/json_web_token.rb
class JsonWebToken
  class << self
    def authenticate(token, sub)
      decoded_auth_payload = decode(token, sub)

      user ||= User.find(decoded_auth_payload[:user_id]) if decoded_auth_payload

      return user if user && decoded_auth_payload[:signature] &&
                     ActiveSupport::SecurityUtils.secure_compare(
                       user.send("#{sub}_signature"),
                       decoded_auth_payload[:signature])

      # Return nil if the user could not be authenticated
      nil
    end

    def generate_token(user, sub, exp = 24.hours.from_now)
      payload = { user_id: user.id,
                  signature: user.auth_signature,
                  sub: sub.to_s,
                  exp: exp.to_i }

      encode(payload)
    end

    private

    def encode(payload)
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token, sub)
      claims = { 'sub' => sub.to_s, verify_sub: true }
      key = Rails.application.secrets.secret_key_base
      body = JWT.decode(token, key, true, claims)[0]

      HashWithIndifferentAccess.new body
    rescue
      # Return nil if token is invalid
      nil
    end
  end
end
