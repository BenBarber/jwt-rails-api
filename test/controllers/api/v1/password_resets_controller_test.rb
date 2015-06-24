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
    end
  end
end
