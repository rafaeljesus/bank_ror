require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @account = accounts(:one)
  end

  test "should create account" do
    assert_difference('Account.count') do
      post accounts_url, params: { account: {  } }, as: :json
    end

    assert_response 201
  end

  test "should update account" do
    patch account_url(@account), params: { account: {  } }, as: :json
    assert_response 200
  end
end
