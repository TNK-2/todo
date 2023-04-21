module Api
  module V1
    class SessionsController < ApplicationController

      def check_token
        authorize_request
        if @current_user
          render json: { result: 'ok' }
        else
          render json: { error: 'User not found' }, status: :unprocessable_entity
        end
      end

      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          expired_date = Time.zone.now + 30.minutes
          render json: { token: JsonWebToken.encode(user_id: user.id, expired_date: expired_date), expired_date: expired_date }, status: :created
        else
          render json: { error: 'Invalid email/password combination' }, status: :unprocessable_entity
        end
      end
    end
  end
end
