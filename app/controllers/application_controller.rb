class ApplicationController < ActionController::API

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      if (is_expired)
        throw 
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    rescue StandardError::SessionExpiredError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  private
    def is_expired
      expired_date = @decoded.expired_date
      if Time.zone.now >= expired_date
        raise SessionExpiredError, 'Session expired'
      end
    end
end
