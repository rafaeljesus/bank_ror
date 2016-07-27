class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  attr_reader :current_user

  protected
  def authenticate!
    unless user_id_in_token?
      render json: {errors: ['Not Authenticated']}, status: :unauthorized
      return
    end
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render json: {errors: ['Not Authenticated']}, status: :unauthorized
  end

  private
  def http_token
    @http_token ||= if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def auth_token
    @auth_token ||= JwtToken.decode(http_token)
  end

  def user_id_in_token?
    http_token && auth_token && auth_token[:user_id].to_i
  end
end
