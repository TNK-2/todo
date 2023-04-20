class ApplicationController < ActionController::API
  class SessionExpiredError < StandardError; end

  rescue_from SessionExpiredError, with: :handle_session_expired_error

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      is_expired
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private
    def is_expired
      expired_date = @decoded[:expired_date]
      if Time.zone.now >= expired_date
        raise SessionExpiredError, 'Session expired'
      end
    end

    def handle_session_expired_error(e)
      render json: { errors: e.message }, status: :unauthorized
    end
end
