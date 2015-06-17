require 'test_helper'

module Api
  module V1
    # Tests for the registrations controller
    class RegistrationsControllerTest < ActionController::TestCase
      test 'post#signup' do
        email = 'test@test.com'
        post :signup, user: { name: 'test',
                              email: email,
                              password: 'Password',
                              password_confirmation: 'Password' }

        result = JSON.parse(response.body)
        assert_equal 200, response.status
        assert_instance_of String, result['token']
        assert_instance_of Fixnum, result['user_id']
        assert_includes result['email'], email
      end

      #
      # Validation tests
      # The tests below contain invalid data to test the model validations
      #

      test 'post#signup with invalid password confirmation' do
        post :signup, user: { name: 'test',
                              email: 'test@test.com',
                              password: 'Password',
                              password_confirmation: '' }

        result = JSON.parse(response.body)
        assert_equal 422, response.status
        assert_includes result['errors'],
                        "Password confirmation doesn't match Password"
      end

      test 'post#signup with taken email' do
        user = users(:one)

        post :signup, user: user.attributes

        result = JSON.parse(response.body)
        assert_equal 422, response.status
        assert_includes result['errors'], 'Email has already been taken'
      end

      test 'post#signup with invalid data' do
        post :signup, user: User.new.attributes

        result = JSON.parse(response.body)
        assert_equal 422, response.status
        assert_includes result['errors'], "Name can't be blank"
        assert_includes result['errors'], "Password can't be blank"
        assert_includes result['errors'], "Email can't be blank"
        assert_includes result['errors'], 'Email is invalid'
      end
    end
  end
end
