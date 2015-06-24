require 'test_helper'

module Api
  module V1
    # Tests for the users controller
    class UsersControllerTest < ActionController::TestCase
      test 'get#index' do
        user = users(:one)
        jwt = user.generate_jwt_auth_token
        token = %(Token token="#{jwt}")
        @request.headers['HTTP_AUTHORIZATION'] = token

        get :index

        assert_equal token, request.env['HTTP_AUTHORIZATION']

        result = JSON.parse(response.body)
        assert_equal 200, response.status
        assert_equal User.all.count, result['users'].count
      end

      #
      # Authentication tests
      # The tests below contain invalid data to test the authentication
      #

      test 'get#index with invalid authorization header' do
        token = %(Token token="invalid")
        @request.headers['HTTP_AUTHORIZATION'] = token

        get :index

        assert_equal token, request.env['HTTP_AUTHORIZATION']

        result = JSON.parse(response.body)
        assert_equal 401, response.status
        assert_equal 401, result['status']
        assert_includes result['errors'], 'Unauthorized'
      end
    end
  end
end
