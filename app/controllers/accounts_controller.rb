class AccountsController < ApplicationController
  before_action :authenticate!
  before_action :set_account, only: [:deposit, :withdraw, :transfer]

  def create
    if Account.open(account_params)
      return render status: :created
    end
    render_unprocessable_entity(:open)
  end

  def deposit
    if Account.deposit(@account, params[:amount])
      return render json: {deposited: true}
    end
    render_unprocessable_entity(:deposit)
  end

  def withdraw
    if Account.withdraw(@account, params[:amount])
      return render json: {withdrawn: true}
    end
    render_unprocessable_entity(:withdraw)
  end

  def transfer
    recipient = Account.find(params[:recipient_id])
    if Account.transfer(@account, recipient, params[:amount])
      return render json: {transfered: true}
    end
    render_unprocessable_entity(:transfer)
  end

  private
  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:name, :user_id)
  end
end
