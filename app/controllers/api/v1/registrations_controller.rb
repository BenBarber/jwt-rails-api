module Api
  module V1
    # Registrations controller
    class RegistrationsController < ApplicationController
      skip_before_action :authenticate_user!

      def signup
        @user = User.new(signup_params)
        if @user.valid? && @user.save
          token = JsonWebToken.generate_token(@user, :auth)

          render json: { token: token, user_id: @user.id, email: @user.email }
        else
          render_error(@user.errors, 422)
        end
      end

      private

      def signup_params
        params.require(:user).permit(:name,
                                     :email,
                                     :password,
                                     :password_confirmation)
      end
    end
  end
end
