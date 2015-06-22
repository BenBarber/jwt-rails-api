require 'test_helper'

module Api
  module V1
    # Tests for the sessions controller
    class SessionsControllerTest < ActionController::TestCase
      test 'post#create' do
        user = users(:one)
        post :create, email: user.email, password: default_password

        result = JSON.parse(response.body)
        assert_equal 200, response.status
        assert_instance_of String, result['token']
        assert_instance_of Fixnum, result['user_id']
        assert_equal user.id, result['user_id']
        assert_includes result['email'], user.email
      end

      test 'post#create with invalid credentials' do
        user = users(:one)
        post :create, email: user.email, password: 'invalidpassword'

        result = JSON.parse(response.body)
        assert_equal 422, response.status
        assert_includes result['errors'], 'Invalid email or password'
      end

      test 'delete#destroy' do
        user = users(:one)
        jwt = JsonWebToken.generate_token(user, :auth)
        token = %(Token token="#{jwt}")
        @request.headers['HTTP_AUTHORIZATION'] = token

        # Initial request to invalidate current session token
        delete :destroy

        assert_equal token, request.env['HTTP_AUTHORIZATION']

        result = JSON.parse(response.body)
        assert_equal 200, response.status
        assert_includes result['message'], 'You have been logged out'

        # Request to verify the current session token is no longer valid
        delete :destroy

        assert_equal token, request.env['HTTP_AUTHORIZATION']

        result = JSON.parse(response.body)
        assert_equal 401, response.status
        assert_equal 401, result['status']
        assert_includes result['errors'], 'Unauthorized'
      end
    end
  end
end
