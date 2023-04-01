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
          render json: { token: ::JWT.encode(user_id: user.id) }
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end

    end
  end
end
