module Api
  module V1
    class SessionsController < ApplicationController
      def create
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          render json: { token: JsonWebToken.encode(user_id: user.id) }
        else
          render json: { error: 'Invalid email/password combination' }, status: :unprocessable_entity
        end
      end
    end
  end
end
