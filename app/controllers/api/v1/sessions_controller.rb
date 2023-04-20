module Api
  module V1
    class SessionsController < ApplicationController
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
