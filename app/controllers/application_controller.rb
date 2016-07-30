class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  attr_reader :current_user

  protected
  def authenticate!
    return render_not_authenticated unless user_id_in_token?
    @current_user = User.find(auth_token[:user_id])
  rescue JWT::VerificationError, JWT::DecodeError
    render_not_authenticated
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

  def render_not_authenticated
    render json: {errors: ['Not Authenticated']}, status: :unauthorized
  end
end
