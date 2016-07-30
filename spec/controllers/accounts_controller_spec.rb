require 'rails_helper'

describe AccountsController do
  let!(:user) { User.create({email: 'foo@mail.com', password: '12345678'})  }
  let!(:account) { Account.create({name: 'Foo', user_id: user.id, balance: 9.99}) }
  let(:token) { JwtToken.encode({user_id: user.id}) }

  after do
    Account.delete_all
  end

  describe 'POST create' do
    context 'with valid params' do
      let(:params) { { account: { name: 'Foo', user_id: user.id } } }

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
      let!(:user_recipient) { User.create({email: 'bar@mail.com', password: '12345678'})  }
      let(:params_recipient) { { name: 'Foo', user_id:  user_recipient.id, balance: 0.00 } }
      let!(:recipient) { Account.create(params_recipient) }
      let(:params) { { id: account.id, recipient_id: recipient.id, amount: 5.00 } }

      it 'returns 200' do
        request.headers['Authorization'] = "Bearer #{token}"
        post :transfer, params: params, as: :json
        expect(response).to have_http_status(:success)
      end
    end
  end
end
