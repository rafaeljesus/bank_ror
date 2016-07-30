require 'rails_helper'

describe TokenController do
  let(:params) { { email: 'foo@mail.com', password: '12345678' } }
  let!(:user) { User.create(params) }

  after do
    User.delete_all
  end

  describe 'POST create' do
    context 'with valid params' do
      let(:token) { JwtToken.encode({user_id: user.id}) }

      it 'returns created token' do
        post :create, params: params, as: :json
        expect(response_body_as_json['token']).to eq token
      end
    end

    context 'with invalid email' do
      let(:params_invalid_email) { { email: 'bar@mail.com', password: '12345678' } }

      it 'returns unauthorized' do
        post :create, params: params_invalid_email, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid password' do
      let(:params_invalid_password) { { email: 'foo@mail.com', password: 'invalid' } }

      it 'returns unauthorized' do
        post :create, params: params_invalid_password, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
