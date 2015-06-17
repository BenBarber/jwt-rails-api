# lib/json_web_token.rb
class JsonWebToken
  class << self
    def authenticate(token)
      decoded_auth_payload = decode(token)

      user ||= User.find(decoded_auth_payload[:user_id]) if decoded_auth_payload

      return user if user && decoded_auth_payload[:signiture] &&
                     ActiveSupport::SecurityUtils.secure_compare(
                       user.token_signiture,
                       decoded_auth_payload[:signiture])

      # Return nil if the user could not be authenticated
      nil
    end

    def generate_token(user)
      token = encode(user_id: user.id, signiture: user.token_signiture)

      # Return the generated token
      token
    end

    private

    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue
      # Return nil if token is invalid
      nil
    end
  end
end
