module Api
  module V1
    # Password resets controller
    class PasswordResetsController < ApplicationController
      skip_before_action :authenticate_user!

      def create
        @user = User.find_by_email(params[:email])

        if @user
          token = @user.generate_jwt_reset_token
          UserMailer.password_reset(@user, token).deliver_now

          return render json: { message:
            "Password reset instructions have been sent to #{@user.email}" }
        end

        render_error({ response:
            'No user was found with that email address' }, 422)
      end

      def reset
        @user = JsonWebToken.authenticate(params[:token], :reset)

        if @user && @user.update_attributes(reset_params)
          return render json: { message: 'Your password has been reset' }
        end

        errors = { response:
            'The reset token provided is either expired or invalid' }
        errors = @user.errors unless @user.nil?

        render_error(errors, 422)
      end

      private

      def reset_params
        params.require(:user).permit(:password,
                                     :password_confirmation)
      end
    end
  end
end
