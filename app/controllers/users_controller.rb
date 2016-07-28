class UsersController < ApplicationController
  def create
    user = User.new(user_params)
    user.save!
    render json: user.as_json(only: [:id])
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
