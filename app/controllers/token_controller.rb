class TokenController < ApplicationController
  def create
    email, password = token_params.values_at(:email, :password)
    user = User.find_by(email: email)
    return render_unauthorized if user.nil? or !user.valid_password?(password)
    render json: payload(user)
  end

  private
  def payload(user)
    return nil unless user and user.id
    {token: JwtToken.encode({user_id: user.id})}
  end

  def token_params
    params.permit(:email, :password)
  end
end
