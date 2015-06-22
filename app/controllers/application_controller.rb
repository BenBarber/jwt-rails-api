# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user!

  protected

  def authenticate_user!
    authenticate_with_http_token do |token, _options|
      @current_user = JsonWebToken.authenticate(token, :auth)
    end
    render_unauthorized unless @current_user
  end

  def current_user
    @current_user ||= nil
  end

  def render_error(errors, code)
    data = errors.map do |key, value|
      if key == :response
        value
      else
        key.to_s.gsub(/_/, ' ').capitalize + ' ' + value
      end
    end

    render json: { errors: data, status: code }, status: code
  end

  def render_unauthorized
    # According to the HTTP spec, a 401 - Unauthorized response must include a
    # WWW-Authenticate header with a challenge applicable to the requested
    # resource which is "Application" in this case
    headers['WWW-Authenticate'] = 'Token realm="Application"'

    render_error({ response: 'Unauthorized' }, 401)
  end
end
