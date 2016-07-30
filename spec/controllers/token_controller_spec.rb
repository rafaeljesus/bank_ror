require 'rails_helper'

describe TokenController do
  let(:params) { attributes_for(:user) }
  let!(:user) { create(:user, params) }

  describe 'POST create' do
    context 'with valid params' do
      let(:token) { JwtToken.encode({user_id: user.id}) }

      it 'returns created token' do
        post :create, params: params, as: :json
        expect(response_body_as_json['token']).to eq token
      end
    end

    context 'with invalid email' do
      let(:params_invalid_email) { attributes_for(:user, password: user.password) }

      it 'returns unauthorized' do
        post :create, params: params_invalid_email, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid password' do
      let(:params_invalid_password) { attributes_for(:user, email: user.email) }

      it 'returns unauthorized' do
        post :create, params: params_invalid_password, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
