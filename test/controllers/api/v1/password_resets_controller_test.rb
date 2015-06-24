require 'test_helper'

module Api
  module V1
    # Tests for the password resets controller
    class PasswordResetsControllerTest < ActionController::TestCase
      test 'POST#create' do
        user = users(:one)
        post :create, email: user.email

        result = JSON.parse(response.body)
        assert_equal 200, response.status
        assert_includes(
          result['message'],
          "Password reset instructions have been sent to #{user.email}")
      end

      test 'POST#create with invalid email' do
        post :create, email: 'test@doesntexsist.com'

        result = JSON.parse(response.body)
        assert_equal 422, response.status
        assert_includes(
          result['errors'],
          'No user was found with that email address')
      end

      test 'POST#reset' do
        user = users(:one)
        token = user.generate_jwt_reset_token
        post :reset, token: token,
                     user: {
                       password: default_password,
                       password_confirmation: default_password
                     }

        result = JSON.parse(response.body)
        assert_equal 200, response.status
        assert_includes result['message'], 'Your password has been reset'
      end

      test 'POST#reset with passwords not matching' do
        user = users(:one)
        token = user.generate_jwt_reset_token
        post :reset, token: token,
                     user: {
                       password: default_password,
                       password_confirmation: 'invalidPassword'
                     }

        result = JSON.parse(response.body)
        assert_equal 422, response.status
        assert_includes result['errors'],
                        "Password confirmation doesn't match Password"
      end

      test 'POST#reset with invalid token' do
        post :reset, token: 'kejnrgkshen',
                     user: {
                       password: default_password,
                       password_confirmation: default_password
                     }

        result = JSON.parse(response.body)
        assert_equal 422, response.status
        assert_includes(
          result['errors'],
          'The reset token provided is either expired or invalid')
      end
    end
  end
end
