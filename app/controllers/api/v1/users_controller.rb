module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize_request, only: [:show]

      def show
        render json: { email: @current_user.email, created_at: @current_user.created_at, updated_at: @current_user.updated_at }
      end

      def create
        user = User.new(user_params)
        if user.save
          expired_date = Time.zone.now + 30.minutes
          render json: { token: JsonWebToken.encode(user_id: user.id, expired_date: expired_date), expired_date: expired_date }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

    end
  end
end
