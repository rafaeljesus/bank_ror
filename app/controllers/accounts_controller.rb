class AccountsController < ApplicationController
  before_action :authenticate!

  def create
    return head :unprocessable_entity unless Account.open(account_params)
    render status: :created
  end

  def deposit
    account = Account.find(params[:id])
    return head :not_found unless account
    return head :unprocessable_entity unless Account.deposit(account, amount)
    render json: {deposited: true}
  end

  def withdraw
    account = Account.find(params[:id])
    return head :not_found unless account
    return head :unprocessable_entity unless Account.withdraw(account, amount)
    render json: {withdrawn: true}
  end

  def transfer
    account = Account.find(params[:id])
    return head :not_found unless account

    recipient_param = params.permit(:recipient_id)
    recipient = Account.find(recipient_param[:recipient_id])
    return head :not_found unless recipient

    return head :unprocessable_entity unless Account.transfer(account, recipient, amount)
    render json: {transfered: true}
  end

  private
  def account_params
    params.require(:account).permit(:name, :user_id)
  end

  def amount
    param = params.permit(:amount)
    param[:amount].to_f
  end
end
