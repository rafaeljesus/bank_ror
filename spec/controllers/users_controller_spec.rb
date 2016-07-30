require 'rails_helper'

describe UsersController do
  describe 'POST create' do
    let(:params) { { user: attributes_for(:user) } }

    it 'returns created user id' do
      post :create, params: params
      expect(response_body_as_json['id']).not_to eq nil
    end
  end
end
