require 'rails_helper'

describe AccountsController do
  let!(:user) { create(:user) }
  let!(:account) { create(:account, user_id: user.id) }
  let(:token) { JwtToken.encode({user_id: user.id}) }

  describe 'POST create' do
    context 'with valid params' do
      let(:params) { { account: attributes_for(:account, user_id: user.id) } }

      it 'returns created status' do
        request.headers['Authorization'] = "Bearer #{token}"
        post :create, params: params, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'POST deposit' do
    context 'with valid params' do
      let(:params) { { id: account.id, amount: 9.99 } }

      it 'returns 200' do
        request.headers['Authorization'] = "Bearer #{token}"
        put :deposit, params: params, as: :json
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST withdraw' do
    context 'with valid params' do
      let(:params) { { id: account.id, amount: 9.99 } }

      it 'returns 200' do
        request.headers['Authorization'] = "Bearer #{token}"
        post :withdraw, params: params, as: :json
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'POST transfer' do
    context 'with valid params' do
      let!(:user_recipient) { create(:user) }
      let!(:recipient) { create(:account, user_id:  user_recipient.id) }
      let(:params) { { id: account.id, recipient_id: recipient.id, amount: 5.00 } }

      it 'returns 200' do
        request.headers['Authorization'] = "Bearer #{token}"
        post :transfer, params: params, as: :json
        expect(response).to have_http_status(:success)
      end
    end
  end
end
