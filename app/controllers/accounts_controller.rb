class AccountsController < ApplicationController
  before_filter :authenticate!
  before_action :set_account, only: [:deposit, :withdraw, :transfer]

  def create
    account = Account.new(account_params)
    account.save
    render json: account
  end

  def deposit
  end

  def withdraw
  end

  def transfer
  end

  private
  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :user_id)
  end
end
