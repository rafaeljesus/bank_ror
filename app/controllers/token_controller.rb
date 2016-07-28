class TokenController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    unless user.valid_password?(params[:password])
      return render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
    render json: payload(user)
  end

  private
  def payload(user)
    return nil unless user and user.id
    {token: JwtToken.encode({user_id: user.id})}
  end
end
