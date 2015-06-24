module Api
  module V1
    # Sessions controller
    class SessionsController < ApplicationController
      skip_before_action :authenticate_user!, except: :destroy

      def create
        @user = User.find_by_email(params[:email])

        if @user && @user.authenticate(params[:password])
          token = @user.generate_jwt_auth_token
          return render json: { token: token,
                                user_id: @user.id,
                                email: @user.email }
        end

        render_error({ response: 'Invalid email or password' }, 422)
      end

      def destroy
        current_user.regenerate_auth_token
        render json: { message: 'You have been logged out' }
      end
    end
  end
end
