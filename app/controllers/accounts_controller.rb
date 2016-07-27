class AccountsController < ApplicationController
  before_filter :authenticate!
  before_action :set_account, only: [:show, :update, :destroy]

  def create
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
    params.fetch(:account, {})
  end
end
